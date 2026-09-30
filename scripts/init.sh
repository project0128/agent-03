#!/bin/bash
# Bash 初始化脚本
# 用于初始化 agent-03 项目的 Git 仓库

set -e  # 遇到错误立即退出

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# 输出函数
write_step() {
    echo -e "${CYAN}==> $1${NC}"
}

write_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

write_warning() {
    echo -e "${YELLOW}⚠ $1${NC}"
}

write_error() {
    echo -e "${RED}✗ $1${NC}"
}

# 切换到项目根目录
cd "$(dirname "$0")/.."

write_step "开始初始化 agent-03 项目..."
echo ""

# 1. 检查 Git 是否安装
write_step "检查 Git 安装..."
if ! command -v git &> /dev/null; then
    write_error "Git 未安装或不在 PATH 中"
    exit 1
fi
git_version=$(git --version)
write_success "Git 已安装: $git_version"

# 2. 初始化 Git 仓库
write_step "初始化 Git 仓库..."
if [ -d ".git" ]; then
    write_warning "Git 仓库已存在，跳过初始化"
else
    git init
    write_success "Git 仓库初始化完成"
fi

# 3. 设置主分支为 main
write_step "设置主分支为 main..."
git branch -M main
write_success "主分支已设置为 main"

# 4. 添加远程仓库
write_step "配置远程仓库..."

GITHUB_USER="项目0128"
GITEE_USER="项目0128"
REPO_NAME="agent-03"

GITHUB_URL="https://github.com/${GITHUB_USER}/${REPO_NAME}.git"
GITEE_URL="https://gitee.com/${GITEE_USER}/${REPO_NAME}.git"

# 检查并添加 origin (GitHub)
if ! git remote | grep -q "^origin$"; then
    git remote add origin "$GITHUB_URL"
    write_success "已添加 origin (GitHub): $GITHUB_URL"
else
    write_warning "origin 已存在，跳过"
fi

# 检查并添加 gitee
if ! git remote | grep -q "^gitee$"; then
    git remote add gitee "$GITEE_URL"
    write_success "已添加 gitee (Gitee): $GITEE_URL"
else
    write_warning "gitee 已存在，跳过"
fi

# 5. 添加所有文件
write_step "添加项目文件..."
git add .
write_success "文件添加完成"

# 6. 创建首次提交
write_step "创建首次提交..."
git commit -m "feat: 初始化 agent-03 项目

- 搭建项目基础结构
- 添加安全约束框架（宪法层、沙箱层、验证层）
- 配置 .gitignore 保护敏感数据
- 创建核心文档（README、架构设计、设计决策）
- 设置 GitHub 和 Gitee 双平台托管
- 添加贡献指南和更新日志

项目状态：早期设计阶段"
write_success "首次提交完成"

# 7. 显示当前状态
echo ""
write_step "当前 Git 状态:"
git status
git remote -v

echo ""
write_success "初始化完成！"
echo ""
echo -e "${CYAN}下一步操作:${NC}"
echo "1. 在 GitHub 创建仓库: https://github.com/new"
echo "   仓库名: agent-03"
echo "   不要初始化 README/.gitignore/LICENSE"
echo ""
echo "2. 在 Gitee 创建仓库: https://gitee.com/projects/new"
echo "   仓库名: agent-03"
echo "   不要初始化 README/.gitignore/LICENSE"
echo ""
echo -e "${YELLOW}3. 推送到远程仓库:${NC}"
echo "   推送到 GitHub:"
echo "   git push -u origin main"
echo ""
echo "   推送到 Gitee:"
echo "   git push -u gitee main"
echo ""
echo -e "${YELLOW}或使用双推脚本:${NC}"
echo "   ./scripts/push-both.sh"
echo ""
