#!/bin/bash

# Auto-detect project root
PROJECT_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
STORAGE_DIR="$PROJECT_ROOT/storage"
COMPOSE_FILE="$PROJECT_ROOT/docker-compose.yml"

echo "======================================"
echo "  AssetStream Health Check"
echo "======================================"

echo "[1/3] Checking Backend API on port 4000..."
if nc -z localhost 4000; then
    echo "✅ Backend is running"
else
    echo "❌ Backend is NOT running"
fi

echo "[2/3] Checking Frontend on port 3000..."
if nc -z localhost 3000; then
    echo "✅ Frontend is running"
else
    echo "❌ Frontend is NOT running"
fi

echo "[3/3] Checking storage folder..."
if [ -d "$STORAGE_DIR" ]; then
    echo "✅ Storage folder exists"
else
    echo "❌ Storage folder does NOT exist ($STORAGE_DIR)"
fi

if [ -f "$COMPOSE_FILE" ]; then
    echo "[Docker] Checking container health..."
    docker compose -f "$COMPOSE_FILE" ps
else
    echo "⚠ docker-compose.yml not found at $COMPOSE_FILE"
fi

echo "======================================"
echo "Health check completed!"
echo "======================================"
