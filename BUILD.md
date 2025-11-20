# Night GameServer 编译说明

## 项目状态

✅ Git 仓库已初始化并提交
- 提交 ID: 6a4e7d7
- 提交信息: "Initial commit: Night GameServer PVP project"
- 文件数: 107 个文件

## 编译要求

### 必需组件

1. **Visual Studio 2010 或更高版本**
   - 项目使用 ToolsVersion="4.0"
   - 需要 C++ 编译工具链

2. **依赖目录**（当前缺失）
   - `../../PropertySheets/` - 项目属性表
   - `../../CrossRoads/` - 共享代码库（包含 PVP 功能）
   - `../../libs/` - 各种库项目
   - `../../core/` - 核心系统
   - `../../utilities/bin/structparser` - 预构建工具

3. **预构建工具**
   - structparser.exe - 用于生成自动代码

## 当前项目结构

```
Night/
├── GameServer/      # 游戏服务器（PVP 功能所在）
├── AppServer/       # 应用服务器
├── GameClient/      # 游戏客户端
├── Common/          # 共享代码
├── MasterSolution/  # 主解决方案
└── bin/            # 运行时 DLL
```

## 编译步骤

### 方法 1: 使用 Visual Studio

1. 打开 `MasterSolution/NNOMasterSolution.sln`
2. 或打开 `GameServer/NNOGameServer.sln`
3. 选择配置（Debug/Full Debug）
4. 生成解决方案

### 方法 2: 使用 MSBuild

```powershell
# 需要先设置 Visual Studio 环境变量
& "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\MSBuild\Current\Bin\MSBuild.exe" `
  "Night\GameServer\NNOGameServer.sln" `
  /p:Configuration=Debug `
  /p:Platform=Win32
```

## 已知问题

⚠️ **无法独立编译**
- 项目依赖上级目录的多个库和工具
- 缺少 PropertySheets 配置文件
- 缺少 structparser 预构建工具
- 缺少 CrossRoads 目录（包含完整的 PVP 实现）

## PVP 功能位置

完整的 PVP 实现代码在：
- `Cryptic/CrossRoads/Common/pvp_common.c` - PVP 基础功能
- `Cryptic/CrossRoads/Common/PvPGameCommon.c` - PVP 游戏模式
- `Cryptic/CrossRoads/GameServerLib/gslPVP.c` - PVP 服务器实现
- `Cryptic/CrossRoads/GameServerLib/gslPvPGame.c` - PVP 游戏逻辑

## 建议

1. **获取完整项目结构**
   - 需要包含所有依赖目录
   - 或创建符号链接到依赖目录

2. **使用完整项目编译**
   - 从项目根目录编译
   - 确保所有依赖都在正确位置

3. **检查编译工具**
   - 安装 Visual Studio 2010+
   - 或安装 Build Tools for Visual Studio

