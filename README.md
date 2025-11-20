# Night GameServer - PVP 功能项目

## 项目简介

这是一个基于 Cryptic Studios 引擎的游戏服务器项目，包含完整的 PVP（玩家对战）功能实现。

## Git 仓库状态

✅ **已初始化并提交**
- 提交历史：
  - `6a4e7d7` - Initial commit: Night GameServer PVP project
  - `80059f4` - Add build script and documentation
  - `4a8b2da` - Fix build script encoding
  - `a43e499` - Add dependency setup script and documentation

## 项目结构

```
Night/
├── GameServer/          # 游戏服务器（主要代码）
│   ├── AutoGen/         # 自动生成的代码
│   └── NNOLogging.c     # 日志功能
├── AppServer/           # 应用服务器
├── GameClient/          # 游戏客户端
├── Common/              # 共享代码
├── MasterSolution/      # Visual Studio 解决方案
├── bin/                 # 运行时 DLL 文件
├── build.ps1            # 编译脚本
├── setup_dependencies.ps1  # 依赖配置脚本
├── BUILD.md             # 编译说明
├── SETUP.md             # 依赖配置说明
└── README.md            # 本文件
```

## PVP 功能

### 已实现的 PVP 功能

1. **决斗系统（Duel）**
   - 1v1 玩家决斗
   - 请求/接受/拒绝机制
   - 区域检测和胜负判定

2. **团队决斗（Team Duel）**
   - 多对多团队战斗
   - 团队邀请和状态管理

3. **PVP 游戏模式**
   - 死亡竞赛（Deathmatch）
   - 夺旗（Capture The Flag）
   - 占领（Domination）
   - 最后一人（Last Man Standing）
   - 塔防（Tower Defense）
   - 自定义模式

4. **积分和奖励系统**
   - 击杀/助攻积分
   - 奖励表系统
   - 排行榜集成

### PVP 代码位置

完整实现代码在 `Cryptic/CrossRoads/` 目录：
- `Common/pvp_common.c` - PVP 基础功能
- `Common/PvPGameCommon.c` - PVP 游戏模式定义
- `GameServerLib/gslPVP.c` - PVP 服务器实现
- `GameServerLib/gslPvPGame.c` - PVP 游戏逻辑

## 快速开始

### 1. 配置依赖

**以管理员身份运行 PowerShell：**
```powershell
cd I:\wd1\Night
.\setup_dependencies.ps1
```

这将创建必要的符号链接。

### 2. 编译项目

```powershell
cd I:\wd1\Night
.\build.ps1
```

### 3. 使用 Visual Studio

打开 `MasterSolution/NNOMasterSolution.sln` 或 `GameServer/NNOGameServer.sln`

## 依赖要求

### 必需组件

1. **Visual Studio 2010 或更高版本**
   - 需要 C++ 编译工具链
   - 或 Visual Studio Build Tools

2. **依赖目录**
   - `../../CrossRoads/` - 共享代码库（包含 PVP）
   - `../../core/` - 核心系统
   - `../../libs/` - 各种库项目
   - `../../PropertySheets/` - 项目属性表
   - `../../utilities/bin/structparser.exe` - 预构建工具

### 当前状态

✅ **已找到：**
- `I:\wd1\Cryptic\CrossRoads` - PVP 完整实现
- `I:\wd1\Cryptic\Core` - 核心系统

❌ **需要配置：**
- 创建符号链接到 CrossRoads 和 core
- 查找或创建 libs 目录
- 查找或创建 PropertySheets 目录
- 查找 structparser.exe

## 文档

- `BUILD.md` - 详细编译说明
- `SETUP.md` - 依赖配置详细说明
- `build.ps1` - 自动编译脚本
- `setup_dependencies.ps1` - 依赖配置脚本

## 已知问题

⚠️ **无法独立编译**
- 项目依赖上级目录的多个库和工具
- 需要完整的项目结构才能编译

## 下一步

1. 运行 `setup_dependencies.ps1` 配置依赖
2. 查找缺失的 libs 和 PropertySheets 目录
3. 安装 Visual Studio 或 Build Tools
4. 尝试编译项目

## 许可证

Copyright (c) 2005-2006, Cryptic Studios
All Rights Reserved
Confidential Property of Cryptic Studios

