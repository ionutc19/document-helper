def test_health(client):
    response = client.get("/api/health")
    assert response.status_code == 200
    data = response.json()
    assert data["status"] == "ok"


def test_explain_analyze(client):
    response = client.post(
        "/api/explain/analyze",
        json={
            "document_text": "This is a test document with enough content to pass validation.",
            "language": "en",
        },
    )
    assert response.status_code == 200
    data = response.json()
    assert "summary" in data
    assert "key_points" in data
    assert "obligations" in data
    assert "risks" in data
    assert "action_items" in data


def test_create_generate(client):
    response = client.post(
        "/api/create/generate",
        json={
            "document_text": "",
            "output_type": "email",
            "instructions": "Write a professional email about a meeting.",
            "language": "en",
        },
    )
    assert response.status_code == 200
    data = response.json()
    assert "generated_text" in data
    assert data["output_type"] == "email"


def test_entitlements(client):
    response = client.get(
        "/api/entitlements/me",
        headers={"X-User-Id": "test-user", "X-Device-Id": "test-device"},
    )
    assert response.status_code == 200
    data = response.json()
    assert data["tier"] == "free"
    assert "explain" in data["usage"]
    assert "create" in data["usage"]


def test_explain_validation(client):
    response = client.post(
        "/api/explain/analyze",
        json={"document_text": "short", "language": "en"},
    )
    assert response.status_code == 422


def test_create_validation(client):
    response = client.post(
        "/api/create/generate",
        json={
            "document_text": "",
            "output_type": "email",
            "instructions": "hi",
            "language": "en",
        },
    )
    assert response.status_code == 422
