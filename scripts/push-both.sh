#!/bin/bash
# Bash 双推脚本
# 同时推送到 GitHub 和 Gitee

set -e

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'

write_step() {
    echo -e "${CYAN}==> $1${NC}"
}

write_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

write_error() {
    echo -e "${RED}✗ $1${NC}"
}

# 切换到项目根目录
cd "$(dirname "$0")/.."

write_step "开始双推操作..."
echo ""

# 检查是否有未提交的更改
if ! git diff --quiet || ! git diff --cached --quiet; then
    write_error "有未提交的更改，请先 commit"
    exit 1
fi

# 推送到 GitHub
write_step "推送到 GitHub (origin)..."
if ! git push origin main; then
    write_error "GitHub 推送失败"
    echo -e "${YELLOW}请检查:${NC}"
    echo "  1. GitHub 仓库是否已创建"
    echo "  2. 远程 URL 是否正确"
    echo "  3. 是否需要配置认证"
    exit 1
fi
write_success "GitHub 推送成功"

echo ""

# 推送到 Gitee
write_step "推送到 Gitee (gitee)..."
if ! git push gitee main; then
    write_error "Gitee 推送失败"
    echo -e "${YELLOW}请检查:${NC}"
    echo "  1. Gitee 仓库是否已创建"
    echo "  2. 远程 URL 是否正确"
    echo "  3. 是否需要配置认证"
    exit 1
fi
write_success "Gitee 推送成功"

echo ""
write_success "双推完成！"
echo ""
echo -e "${CYAN}GitHub: https://github.com/项目0128/agent-03${NC}"
echo -e "${CYAN}Gitee:  https://gitee.com/项目0128/agent-03${NC}"
echo ""
