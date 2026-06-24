from pydantic import BaseModel, Field


class UsageMeta(BaseModel):
    tier: str = "free"
    used: int = 0
    remaining: int = 5
    period_seconds: int = 2592000
    show_upgrade: bool = True


class ExplainRequest(BaseModel):
    document_text: str = Field(
        ..., min_length=10, description="Document content to explain",
    )
    language: str = Field(default="en", pattern="^(en|ro)$")


class ExplainResponse(BaseModel):
    summary: str
    key_points: list[str]
    obligations: list[str]
    risks: list[str]
    action_items: list[str]
    usage: UsageMeta | None = None


class CreateRequest(BaseModel):
    document_text: str = Field(
        default="", description="Source document for context (optional)",
    )
    output_type: str = Field(
        ..., description="Type of document to generate",
    )
    instructions: str = Field(
        ..., min_length=5, description="User instructions for generation",
    )
    language: str = Field(default="en", pattern="^(en|ro)$")


class CreateResponse(BaseModel):
    generated_text: str
    output_type: str
    usage: UsageMeta | None = None


class FeedbackRequest(BaseModel):
    category: str = Field(
        ..., pattern="^(bug|feature|feedback)$",
    )
    title: str = Field(..., min_length=3, max_length=200)
    description: str = Field(..., min_length=10)
    email: str = ""


class FeedbackResponse(BaseModel):
    success: bool
    message: str
    issue_url: str = ""


class HealthResponse(BaseModel):
    status: str
    version: str


class UserTierRequest(BaseModel):
    tier: str = Field(pattern="^(free|premium|pro)$")


class UserTierResponse(BaseModel):
    tier: str
    usage: dict[str, UsageMeta]
    subscription: dict | None = None


class VerifyPurchaseRequest(BaseModel):
    product_id: str = Field(
        ...,
        pattern=(
            "^(docassist_premium_monthly"
            "|docassist_pro_monthly)$"
        ),
    )
    purchase_token: str = Field(..., min_length=1)


class VerifyPurchaseResponse(BaseModel):
    valid: bool
    tier: str = "free"
    error: str = ""
    message: str = ""


class RtdnNotification(BaseModel):
    message: dict
    subscription: str = ""
