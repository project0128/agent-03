# PowerShell 双推脚本
# 同时推送到 GitHub 和 Gitee

$ErrorActionPreference = "Stop"

function Write-Step {
    param([string]$Message)
    Write-Host "==> $Message" -ForegroundColor Cyan
}

function Write-Success {
    param([string]$Message)
    Write-Host "OK $Message" -ForegroundColor Green
}

function Write-Error {
    param([string]$Message)
    Write-Host "ERROR $Message" -ForegroundColor Red
}

# 切换到项目根目录
$projectRoot = Split-Path -Parent $PSScriptRoot
Set-Location $projectRoot

Write-Step "开始双推操作..."
Write-Host ""

# 检查是否有未提交的更改
$status = git status --porcelain
if ($status) {
    Write-Error "有未提交的更改，请先 commit"
    exit 1
}

# 推送到 GitHub
Write-Step "推送到 GitHub (origin)..."
try {
    git push origin main
    Write-Success "GitHub 推送成功"
} catch {
    Write-Error "GitHub 推送失败: $_"
    Write-Host "请检查:" -ForegroundColor Yellow
    Write-Host "  1. GitHub 仓库是否已创建" -ForegroundColor Yellow
    Write-Host "  2. 远程 URL 是否正确" -ForegroundColor Yellow
    Write-Host "  3. 是否需要配置认证" -ForegroundColor Yellow
    exit 1
}

Write-Host ""

# 推送到 Gitee
Write-Step "推送到 Gitee (gitee)..."
try {
    git push gitee main
    Write-Success "Gitee 推送成功"
} catch {
    Write-Error "Gitee 推送失败: $_"
    Write-Host "请检查:" -ForegroundColor Yellow
    Write-Host "  1. Gitee 仓库是否已创建" -ForegroundColor Yellow
    Write-Host "  2. 远程 URL 是否正确" -ForegroundColor Yellow
    Write-Host "  3. 是否需要配置认证" -ForegroundColor Yellow
    exit 1
}

Write-Host ""
Write-Success "双推完成！"
Write-Host ""
Write-Host "GitHub: https://github.com/项目0128/agent-03" -ForegroundColor Cyan
Write-Host "Gitee:  https://gitee.com/项目0128/agent-03" -ForegroundColor Cyan
Write-Host ""
