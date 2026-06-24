# Document Assistant

A mobile-first Android app that helps users understand documents and generate contextual outputs.

## Modules

- **Explain** — Summarize, extract key points, highlight obligations/risks/action items.
- **Create** — Generate contextual documents: requests, complaints, official replies, emails, and more.

## Structure

```
mobile/     Flutter mobile app (Android-first)
server/     Python FastAPI backend
docs/       Privacy policy, terms of service
branding/   Logos, icons, feature graphics
```

## Local Development

### Server

```bash
cd server
python -m venv venv && source venv/bin/activate
pip install -r requirements.txt
cp .env.example .env   # edit with your keys
uvicorn app.main:app --reload
```

### Mobile

```bash
cd mobile
flutter pub get
flutter run                                        # mock mode (default)
flutter run --dart-define=USE_MOCKS=false           # live backend
flutter run --dart-define=BASE_URL=http://10.0.2.2:8000  # custom backend URL
```

## Privacy

- No uploaded file content is stored persistently.
- No extracted text is stored persistently.
- No document contents are logged.
- All processing is temporary and request-scoped.
