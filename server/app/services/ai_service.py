import json
import logging

import httpx

from app.config import settings
from app.models.schemas import (
    CreateRequest,
    CreateResponse,
    ExplainRequest,
    ExplainResponse,
)

logger = logging.getLogger(__name__)


def _ai_configured() -> bool:
    return bool(settings.ai_api_key and settings.ai_base_url)


async def _call_ai(prompt: str) -> str:
    if not _ai_configured():
        return ""

    headers = {
        "Authorization": f"Bearer {settings.ai_api_key}",
        "Content-Type": "application/json",
    }
    payload = {
        "model": settings.ai_model,
        "input": [{"role": "user", "content": prompt}],
        "temperature": 0.7,
    }

    async with httpx.AsyncClient(
        timeout=settings.ai_timeout_seconds,
    ) as client:
        response = await client.post(
            f"{settings.ai_base_url}/responses",
            json=payload,
            headers=headers,
        )
        response.raise_for_status()
        data = response.json()
        for item in data.get("output", []):
            if item.get("type") == "message":
                for block in item.get("content", []):
                    if block.get("type") == "output_text":
                        return block["text"]
        return ""


def _parse_json(text: str) -> dict | None:
    cleaned = text.strip()
    if cleaned.startswith("```"):
        lines = cleaned.split("\n")
        lines = lines[1:]
        if lines and lines[-1].strip() == "```":
            lines = lines[:-1]
        cleaned = "\n".join(lines)
    try:
        return json.loads(cleaned)
    except (json.JSONDecodeError, ValueError):
        logger.warning("Failed to parse AI JSON response")
        return None


_LANG_INSTRUCTION = {
    "en": "Respond entirely in English.",
    "ro": "Răspunde complet în limba română.",
}


def _fallback_explain(request: ExplainRequest) -> ExplainResponse:
    lang = request.language
    text = request.document_text
    word_count = len(text.split())

    if lang == "ro":
        summary = (
            f"Documentul conține aproximativ {word_count} cuvinte. "
            f"O analiză detaliată necesită procesare AI. "
            f"Mai jos sunt informațiile de bază extrase."
        )
        return ExplainResponse(
            summary=summary,
            key_points=["Documentul a fost încărcat și procesat cu succes"],
            obligations=["Verificați cerințele specifice din document"],
            risks=["Nu au fost identificate riscuri majore automat"],
            action_items=["Revizuiți documentul complet pentru detalii"],
        )

    summary = (
        f"The document contains approximately {word_count} words. "
        f"Detailed analysis requires AI processing. "
        f"Below is the basic information extracted."
    )
    return ExplainResponse(
        summary=summary,
        key_points=["Document was uploaded and processed successfully"],
        obligations=["Review specific requirements in the document"],
        risks=["No major risks identified automatically"],
        action_items=["Review the full document for details"],
    )


def _fallback_create(request: CreateRequest) -> CreateResponse:
    lang = request.language
    output_type = request.output_type

    if lang == "ro":
        generated = (
            f"[Document generat — tip: {output_type}]\n\n"
            f"Pe baza instrucțiunilor dumneavoastră:\n"
            f"{request.instructions}\n\n"
            f"Generarea completă a documentului necesită procesare AI. "
            f"Aceasta este o versiune de bază. Vă rugăm să configurați "
            f"serviciul AI pentru rezultate complete."
        )
    else:
        generated = (
            f"[Generated document — type: {output_type}]\n\n"
            f"Based on your instructions:\n"
            f"{request.instructions}\n\n"
            f"Full document generation requires AI processing. "
            f"This is a basic version. Please configure the AI "
            f"service for complete results."
        )

    return CreateResponse(
        generated_text=generated,
        output_type=output_type,
    )


def _explain_prompt(request: ExplainRequest) -> str:
    lang_inst = _LANG_INSTRUCTION.get(
        request.language, _LANG_INSTRUCTION["en"],
    )
    return f"""{lang_inst}

Analyze the following document thoroughly.
Return ONLY valid JSON with this exact structure:
{{
  "summary": "<clear 2-4 sentence summary of the document>",
  "key_points": ["<key point 1>", "<key point 2>", "..."],
  "obligations": ["<obligation or requirement 1>", "..."],
  "risks": ["<risk or concern 1>", "..."],
  "action_items": ["<action item 1>", "..."]
}}

Provide up to 5 items per category. If a category has no items, return an empty list.
Focus on making the content accessible and easy to understand.
Highlight any deadlines, financial obligations, or legal requirements.

Document:
{request.document_text}"""


def _create_prompt(request: CreateRequest) -> str:
    lang_inst = _LANG_INSTRUCTION.get(
        request.language, _LANG_INSTRUCTION["en"],
    )
    context_section = ""
    if request.document_text:
        context_section = f"""
Source document for context:
{request.document_text}
"""

    return f"""{lang_inst}

Generate a document of type: {request.output_type}

User instructions:
{request.instructions}
{context_section}
Return ONLY valid JSON with this exact structure:
{{
  "generated_text": "<the complete generated document text>",
  "output_type": "{request.output_type}"
}}

Write professionally and appropriately for the document type.
If a source document is provided, use it as context for the generated output."""


async def explain_document(
    request: ExplainRequest,
) -> ExplainResponse:
    if not _ai_configured():
        return _fallback_explain(request)

    try:
        raw = await _call_ai(_explain_prompt(request))
        data = _parse_json(raw)
        if not data or "summary" not in data:
            logger.warning("AI explain response invalid, using fallback")
            return _fallback_explain(request)

        return ExplainResponse(
            summary=data.get("summary", ""),
            key_points=data.get("key_points", []),
            obligations=data.get("obligations", []),
            risks=data.get("risks", []),
            action_items=data.get("action_items", []),
        )
    except Exception:
        logger.exception("AI explain call failed, using fallback")
        return _fallback_explain(request)


async def create_document(
    request: CreateRequest,
) -> CreateResponse:
    if not _ai_configured():
        return _fallback_create(request)

    try:
        raw = await _call_ai(_create_prompt(request))
        data = _parse_json(raw)
        if not data or "generated_text" not in data:
            logger.warning("AI create response invalid, using fallback")
            return _fallback_create(request)

        return CreateResponse(
            generated_text=data["generated_text"],
            output_type=data.get("output_type", request.output_type),
        )
    except Exception:
        logger.exception("AI create call failed, using fallback")
        return _fallback_create(request)
