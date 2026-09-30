# agent-03 快速设置指南

## 已完成 ✅

- [x] 项目结构创建完成
- [x] Git 仓库初始化完成
- [x] 文档和模板已就位
- [x] 双推脚本已配置
- [x] Git 安装到 E:\Git

## 你需要做的 📝

### 1. 创建远程仓库

**GitHub:**
1. 访问 https://github.com/new
2. Repository name: `agent-03`
3. **不要勾选** 任何初始化选项
4. 点击 Create repository

**Gitee:**
1. 访问 https://gitee.com/projects/new
2. 项目名称: `agent-03`
3. **不要勾选** 任何初始化选项
4. 点击 创建

### 2. 推送代码

打开 PowerShell，执行：

```powershell
cd E:\agent-03
$env:PATH = "E:\Git\cmd;" + $env:PATH
git push -u origin main
git push -u gitee main
```

或使用双推脚本：
```powershell
.\scripts\push-both.ps1
```

## 验证清单 ✅

完成后检查：
- [ ] `git status` 看不到 memories/logs/checkpoints/models 下的任何内容
- [ ] GitHub 和 Gitee 都有 main 分支且内容一致
- [ ] README 在 GitHub 首页渲染正常
- [ ] 目录结构存在但全是空占位，没有真实数据

## 项目结构

```
E:\agent-03\
├── .gitignore              # Git 忽略规则
├── .gitattributes          # Git 属性配置
├── README.md               # 项目说明
├── LICENSE                 # 许可证（暂不开源）
├── CONTRIBUTING.md         # 贡献指南
├── CHANGELOG.md            # 更新日志
├── .github/
│   ├── ISSUE_TEMPLATE/     # Issue 模板
│   └── PULL_REQUEST_TEMPLATE.md
├── docs/
│   ├── architecture.md     # 架构设计
│   └── design-decisions.md # 设计决策
├── src/                    # 源代码（待开发）
├── config/
│   ├── example.yaml        # 配置示例
│   └── .gitkeep
├── data/
│   ├── examples/           # 示例数据
│   ├── memories/           # 记忆存储（忽略）
│   ├── logs/               # 日志（忽略）
│   └── checkpoints/        # 检查点（忽略）
├── models/                 # 模型文件（忽略）
├── scripts/
│   ├── init.ps1            # PowerShell 初始化
│   ├── init.sh             # Bash 初始化
│   ├── push-both.ps1       # PowerShell 双推
│   └── push-both.sh        # Bash 双推
└── tests/                  # 测试（待开发）
```

## 下一步

推送完成后，你可以：
1. 开始开发核心功能
2. 配置 CI/CD（GitHub Actions）
3. 设置项目看板
4. 邀请协作者

---

**Git 路径**: `E:\Git\cmd\git.exe`
**项目路径**: `E:\agent-03\`
