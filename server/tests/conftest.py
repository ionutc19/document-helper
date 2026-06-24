import pytest
from fastapi.testclient import TestClient

from app.config import settings

settings.database_url = "sqlite:///./test_docassist.db"

from app.db import init_db, reset_engine
from app.main import app


@pytest.fixture(autouse=True)
def setup_db():
    reset_engine()
    init_db()
    yield


@pytest.fixture
def client():
    return TestClient(app)
