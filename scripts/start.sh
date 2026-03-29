#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."

if [[ ! -f .env ]]; then
  echo "[信息] 未检测到 .env，自动从 .env.example 创建。"
  cp .env.example .env
  echo "[错误] 请先编辑 .env，设置 OPENCLAW_IMAGE 后再重试。"
  exit 1
fi

image_line="$(grep -E '^OPENCLAW_IMAGE=' .env || true)"
if [[ -z "${image_line}" ]]; then
  echo "[错误] .env 缺少 OPENCLAW_IMAGE 配置。"
  exit 1
fi

if grep -q '<你的账号>' .env || grep -q '<你的-openclaw-镜像>' .env; then
  echo "[错误] 你还在使用 .env.example 占位符，请先填写真实镜像地址。"
  exit 1
fi

if ! docker compose pull; then
  echo "[错误] 镜像拉取失败。"
  echo "[提示] 请先确认 OPENCLAW_IMAGE 是否存在且你有权限访问。"
  echo "[提示] 私有 GHCR 镜像可先登录："
  echo "       echo <GHCR_TOKEN> | docker login ghcr.io -u <GHCR_USERNAME> --password-stdin"
  exit 1
fi

docker compose up -d

echo "[完成] OpenClaw 服务已启动。"
