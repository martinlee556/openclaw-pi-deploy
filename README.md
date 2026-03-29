# OpenClaw Raspberry Pi 4B Docker 部署模板

本仓库用于在 **Raspberry Pi 4B** 上通过 **Docker + Docker Compose** 快速部署 OpenClaw。

> 重要：`openclaw-pi-deploy` 是 **GitHub 仓库名**，不是容器镜像名。请在 `.env` 中填写真实可拉取的镜像地址。

## 目录结构

```text
.
├── .env.example
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

### 1.2 配置镜像与端口（必做）

```bash
cp .env.example .env
nano .env
```

至少要修改：

```env
OPENCLAW_IMAGE=ghcr.io/<你的账号>/<你的-openclaw-镜像>:latest
```

> 不要写成 `ghcr.io/martinlee556/openclaw-pi-deploy:latest`，那是仓库名，不是可用镜像。

### 1.3 执行环境安装脚本

```bash
./scripts/install.sh
```

### 1.4 启动服务

```bash
./scripts/start.sh
```

`start.sh` 会检查：
- `.env` 是否存在
- `OPENCLAW_IMAGE` 是否已填写真实值
- 镜像是否可拉取

### 1.5 一键部署（可选）

```bash
./scripts/deploy.sh
```

## 2. 停止方法

```bash
./scripts/stop.sh
```

## 3. 查看状态方法

```bash
./scripts/status.sh
```

## 4. 常见错误与处理

### 4.1 `the attribute 'version' is obsolete`

本模板已移除 `version` 字段。如果你还看到这个警告，说明你当前目录下仍是旧版 `docker-compose.yml`，请执行：

```bash
git pull
cat docker-compose.yml
```

确认文件开头是 `services:`，而不是 `version: "3.9"`。

### 4.2 `error from registry: denied` 或 `not found`

这通常表示镜像名不正确或无权限：

1. 检查 `.env` 的 `OPENCLAW_IMAGE`
2. 私有 GHCR 镜像先登录：
   ```bash
   echo <GHCR_TOKEN> | docker login ghcr.io -u <GHCR_USERNAME> --password-stdin
   ```
3. 手动验证镜像：
   ```bash
   docker pull "$OPENCLAW_IMAGE"
   ```
4. 再执行：
   ```bash
   ./scripts/start.sh
   ```
