from contextlib import asynccontextmanager

from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from app.db import dispose_engine
from app.routers import (
    admin,
    create,
    entitlements,
    explain,
    feedback,
    file_upload,
    health,
)


@asynccontextmanager
async def lifespan(app: FastAPI):
    yield
    dispose_engine()


app = FastAPI(
    title="Document Assistant API",
    description=(
        "Backend for the Document Assistant mobile app — "
        "document explanation, contextual document generation, "
        "and file processing."
    ),
    version="0.1.0",
    lifespan=lifespan,
)

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(health.router)
app.include_router(explain.router)
app.include_router(create.router)
app.include_router(feedback.router)
app.include_router(entitlements.router)
app.include_router(admin.router)
app.include_router(file_upload.router)
