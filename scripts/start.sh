#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."
docker compose up -d

echo "[完成] OpenClaw 服务已启动。"
