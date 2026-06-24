import logging

from fastapi import APIRouter, Header, HTTPException

from app.models.schemas import ExplainRequest, ExplainResponse, UsageMeta
from app.services.ai_service import explain_document
from app.services.usage_service import (
    check_input_length,
    check_usage,
    ensure_user,
    get_usage_meta,
    get_user_tier,
    record_usage,
)

logger = logging.getLogger(__name__)

router = APIRouter(prefix="/api/explain", tags=["Explain"])

MODULE = "explain"


def _resolve_user(x_user_id: str, x_device_id: str) -> str:
    user_id = x_user_id if x_user_id != "anonymous" else (
        x_device_id if x_device_id != "anonymous" else "anonymous"
    )
    ensure_user(user_id, x_device_id)
    return user_id


@router.post("/analyze", response_model=ExplainResponse)
async def analyze_document(
    request: ExplainRequest,
    x_user_id: str = Header(default="anonymous"),
    x_device_id: str = Header(default="anonymous"),
) -> ExplainResponse:
    user_id = _resolve_user(x_user_id, x_device_id)

    tier = get_user_tier(user_id)
    if not check_input_length(tier, MODULE, len(request.document_text)):
        raise HTTPException(
            status_code=422,
            detail="Document text exceeds the maximum length for your plan.",
        )

    allowed, reason, remaining = check_usage(user_id, MODULE)
    if not allowed:
        raise HTTPException(
            status_code=429,
            detail={"reason": reason, "remaining": 0},
        )

    result = await explain_document(request)
    record_usage(user_id, MODULE)
    result.usage = UsageMeta(**get_usage_meta(user_id, MODULE))
    return result
