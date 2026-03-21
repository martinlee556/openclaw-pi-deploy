#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."

echo "[状态] 容器状态："
docker compose ps

echo

echo "[状态] 最近日志（100 行）："
docker compose logs --tail=100
