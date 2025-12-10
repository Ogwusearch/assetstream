#!/bin/bash

# Auto-detect project root (directory where this script is located)
PROJECT_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
BACKEND_LOG="$PROJECT_ROOT/backend/server.log"
FRONTEND_LOG="$PROJECT_ROOT/frontend/frontend.log"
COMPOSE_FILE="$PROJECT_ROOT/docker-compose.yml"

echo "======================================"
echo "  AssetStream Logs Viewer"
echo "======================================"

# Backend log
if [ -f "$BACKEND_LOG" ]; then
    echo "[Backend] Showing logs:"
    tail -n 20 "$BACKEND_LOG"
else
    echo "⚠ Backend log file not found ($BACKEND_LOG)"
fi

# Frontend log
if [ -f "$FRONTEND_LOG" ]; then
    echo "[Frontend] Showing logs:"
    tail -n 20 "$FRONTEND_LOG"
else
    echo "⚠ Frontend log file not found ($FRONTEND_LOG)"
fi

# Docker logs
if [ -f "$COMPOSE_FILE" ]; then
    echo "[Docker] Showing service logs..."
    docker compose -f "$COMPOSE_FILE" logs --tail=50
else
    echo "⚠ docker-compose.yml not found at $COMPOSE_FILE"
fi

echo "======================================"
echo "Logs displayed successfully!"
echo "======================================"
