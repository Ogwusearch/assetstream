#!/usr/bin/env bash
# =========================================
# AssetStream Setup Script
# =========================================

set -e

echo "======================================"
echo "  AssetStream Setup Script"
echo "======================================"

# 1. Check dependencies
echo "[1/6] Checking system dependencies..."
command -v git >/dev/null 2>&1 || { echo >&2 "Git not found. Please install Git."; exit 1; }
command -v node >/dev/null 2>&1 || { echo >&2 "Node.js not found. Please install Node.js (v18+)."; exit 1; }
command -v npm >/dev/null 2>&1 || { echo >&2 "npm not found. Please install npm."; exit 1; }
command -v docker >/dev/null 2>&1 || echo "⚠ Docker not found. Skipping Docker build."
command -v docker-compose >/dev/null 2>&1 || echo "⚠ docker-compose not found. Skipping Docker build."

echo "✅ All required tools are available."

# 2. Install frontend dependencies
echo "[2/6] Installing frontend dependencies..."
if [ -f "frontend/package.json" ]; then
  cd frontend
  npm install
  cd ..
else
  echo "⚠ frontend/package.json not found. Skipping frontend install."
fi
echo "✅ Frontend dependencies installed."

# 3. Install backend dependencies
echo "[3/6] Installing backend dependencies..."
if [ -f "backend/package.json" ]; then
  cd backend
  npm install
  cd ..
else
  echo "⚠ backend/package.json not found. Skipping backend install."
fi
echo "✅ Backend dependencies installed."

# 4. Prepare .env file
echo "[4/6] Creating .env file for backend..."
ENV_FILE="backend/.env"
if [ ! -f "$ENV_FILE" ]; then
  cat > "$ENV_FILE" <<EOL
PORT=4000
DATABASE_URL=sqlite:./backend/storage/assetstream.db
JWT_SECRET=$(openssl rand -hex 32)
UPLOAD_PATH=./backend/storage
EOL
  echo "✅ .env file created at $ENV_FILE"
else
  echo "⚠ .env file already exists. Skipping creation."
fi

# 5. Create storage folder if missing
echo "[5/6] Ensuring storage folders exist..."
mkdir -p backend/storage
mkdir -p storage
echo "✅ Storage folders ready."

# 6. Build and run Docker containers (optional)
echo "[6/6] Building and starting Docker containers (if docker-compose.yml exists)..."
if [ -f "docker-compose.yml" ]; then
  docker-compose up -d --build
  echo "✅ Docker containers built and running."
else
  echo "⚠ docker-compose.yml not found. Skipping Docker build."
fi

echo "======================================"
echo "  AssetStream setup complete!"
echo "  Frontend: http://localhost:3000 (default)"
echo "  Backend API: http://localhost:4000 (default)"
echo "======================================"
