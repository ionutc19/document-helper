#!/usr/bin/env bash
set -e

echo "Running database migrations..."
python -m alembic upgrade head || echo "Migration skipped (non-critical)"

echo "Starting server..."
exec gunicorn app.main:app \
  --workers 2 \
  --worker-class uvicorn.workers.UvicornWorker \
  --bind 0.0.0.0:8000
