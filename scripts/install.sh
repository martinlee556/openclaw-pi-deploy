#!/usr/bin/env bash
set -euo pipefail

if [[ "${EUID}" -eq 0 ]]; then
  SUDO=""
else
  SUDO="sudo"
fi

ensure_linux() {
  if [[ "$(uname -s)" != "Linux" ]]; then
    echo "[错误] 仅支持 Linux 环境。"
    exit 1
  fi
}

install_docker_if_needed() {
  if command -v docker >/dev/null 2>&1; then
    echo "[信息] Docker 已安装，跳过。"
    return
  fi

  echo "[信息] 开始安装 Docker..."
  curl -fsSL https://get.docker.com | sh
}

install_compose_if_needed() {
  if docker compose version >/dev/null 2>&1; then
    echo "[信息] Docker Compose 插件已安装，跳过。"
    return
  fi

  echo "[信息] 安装 Docker Compose 插件..."
  ${SUDO} apt-get update
  ${SUDO} apt-get install -y docker-compose-plugin
}

add_user_to_docker_group() {
  local user_name
  user_name="${SUDO_USER:-${USER}}"

  if id -nG "${user_name}" | tr ' ' '\n' | grep -qx docker; then
    echo "[信息] 用户 ${user_name} 已在 docker 组，跳过。"
    return
  fi

  echo "[信息] 将用户 ${user_name} 加入 docker 用户组..."
  ${SUDO} usermod -aG docker "${user_name}"
  echo "[提示] 请重新登录后再执行 Docker 无 sudo 命令。"
}

ensure_linux
install_docker_if_needed
install_compose_if_needed
add_user_to_docker_group

echo "[完成] 环境安装与检查已完成。"
