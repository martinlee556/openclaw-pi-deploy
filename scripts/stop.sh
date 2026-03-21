#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."
docker compose down

echo "[完成] OpenClaw 服务已停止。"
