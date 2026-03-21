# OpenClaw Raspberry Pi 4B Docker 部署模板

本仓库用于在 **Raspberry Pi 4B** 上通过 **Docker + Docker Compose** 快速部署 OpenClaw。

> 说明：本模板默认你使用 64 位 Raspberry Pi OS（Bookworm 或更新版本），并且设备可以访问互联网。

## 目录结构

```text
.
├── docker-compose.yml
├── README.md
└── scripts
    ├── deploy.sh
    ├── install.sh
    ├── start.sh
    ├── status.sh
    └── stop.sh
```

## 1. 安装步骤

### 1.1 在 Raspberry Pi 上获取代码

```bash
git clone <你的仓库地址> openclaw-pi-deploy
cd openclaw-pi-deploy
```

### 1.2 执行环境安装脚本

```bash
./scripts/install.sh
```

安装脚本会完成以下操作：
- 检查系统是否为 Linux
- 安装 Docker（如未安装）
- 安装 Docker Compose 插件（如未安装）
- 将当前用户加入 `docker` 用户组（首次安装后建议重新登录）

### 1.3 一键部署（可选）

如果你希望在拉取代码后直接部署，可以使用：

```bash
./scripts/deploy.sh
```

该命令会依次执行安装检查和服务启动。

## 2. 启动方法

```bash
./scripts/start.sh
```

或直接使用：

```bash
docker compose up -d
```

## 3. 停止方法

```bash
./scripts/stop.sh
```

或直接使用：

```bash
docker compose down
```

## 4. 查看状态方法

```bash
./scripts/status.sh
```

状态脚本会输出：
- 当前容器运行状态
- 最近日志（默认 100 行）

## 5. 常用维护命令

更新镜像并重建：

```bash
docker compose pull
docker compose up -d --force-recreate
```

查看实时日志：

```bash
docker compose logs -f
```

## 6. 配置说明

- 默认服务名：`openclaw`
- 默认映射端口：
  - `8080:8080`
  - `9000:9000`
- 数据卷：
  - `./data:/app/data`
  - `./config:/app/config`

请根据你实际的 OpenClaw 镜像地址、端口和配置文件路径修改 `docker-compose.yml`。
