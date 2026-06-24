import logging

from fastapi import APIRouter, Header, HTTPException

from app.models.schemas import CreateRequest, CreateResponse, UsageMeta
from app.services.ai_service import create_document
from app.services.usage_service import (
    check_input_length,
    check_usage,
    ensure_user,
    get_usage_meta,
    get_user_tier,
    record_usage,
)

logger = logging.getLogger(__name__)

router = APIRouter(prefix="/api/create", tags=["Create"])

MODULE = "create"


def _resolve_user(x_user_id: str, x_device_id: str) -> str:
    user_id = x_user_id if x_user_id != "anonymous" else (
        x_device_id if x_device_id != "anonymous" else "anonymous"
    )
    ensure_user(user_id, x_device_id)
    return user_id


@router.post("/generate", response_model=CreateResponse)
async def generate_document(
    request: CreateRequest,
    x_user_id: str = Header(default="anonymous"),
    x_device_id: str = Header(default="anonymous"),
) -> CreateResponse:
    user_id = _resolve_user(x_user_id, x_device_id)

    tier = get_user_tier(user_id)
    total_chars = len(request.document_text) + len(request.instructions)
    if not check_input_length(tier, MODULE, total_chars):
        raise HTTPException(
            status_code=422,
            detail="Input text exceeds the maximum length for your plan.",
        )

    allowed, reason, remaining = check_usage(user_id, MODULE)
    if not allowed:
        raise HTTPException(
            status_code=429,
            detail={"reason": reason, "remaining": 0},
        )

    result = await create_document(request)
    record_usage(user_id, MODULE)
    result.usage = UsageMeta(**get_usage_meta(user_id, MODULE))
    return result
