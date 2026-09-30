# PowerShell init script for agent-03
$ErrorActionPreference = "Stop"

function Write-Step { param([string]$Message); Write-Host "==> $Message" -ForegroundColor Cyan }
function Write-Ok { param([string]$Message); Write-Host "[OK] $Message" -ForegroundColor Green }
function Write-Warn { param([string]$Message); Write-Host "[WARN] $Message" -ForegroundColor Yellow }
function Write-Err { param([string]$Message); Write-Host "[ERROR] $Message" -ForegroundColor Red }

$projectRoot = Split-Path -Parent $PSScriptRoot
Set-Location $projectRoot

Write-Step "Starting agent-03 init..."

# Check Git
try { $v = git --version; Write-Ok "Git installed: $v" } catch { Write-Err "Git not found"; exit 1 }

# Init repo
if (Test-Path ".git") { Write-Warn "Git repo exists, skip init" } else { git init; Write-Ok "Git repo initialized" }

# Set main branch
git branch -M main
Write-Ok "Main branch set to main"

# Add remotes
$ghUrl = "https://github.com/项目0128/agent-03.git"
$ggUrl = "https://gitee.com/项目0128/agent-03.git"

$remotes = git remote
if (-not ($remotes -contains "origin")) { git remote add origin $ghUrl; Write-Ok "Added origin (GitHub)" } else { Write-Warn "origin exists" }
if (-not ($remotes -contains "gitee")) { git remote add gitee $ggUrl; Write-Ok "Added gitee (Gitee)" } else { Write-Warn "gitee exists" }

# Add files and commit
git add .
Write-Ok "Files staged"

$msg = "feat: init agent-03 project"
git commit -m $msg
Write-Ok "Initial commit done"

Write-Host ""
git status
git remote -v
Write-Host ""
Write-Ok "Init complete!"
Write-Host "Next: push to GitHub and Gitee"