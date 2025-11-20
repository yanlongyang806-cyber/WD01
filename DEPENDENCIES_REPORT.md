# 依赖查找报告

## 查找时间
$(Get-Date)

## 项目期望的依赖路径

项目期望在 `I:\wd1\` 目录下有：
- `../../CrossRoads/` → `I:\wd1\CrossRoads\`
- `../../core/` → `I:\wd1\core\`
- `../../libs/` → `I:\wd1\libs\`
- `../../PropertySheets/` → `I:\wd1\PropertySheets\`
- `../../utilities/bin/structparser.exe` → `I:\wd1\utilities\bin\structparser.exe`

## 已找到的依赖

### ✅ CrossRoads
- **位置**: `I:\wd1\Cryptic\CrossRoads\`
- **状态**: 存在
- **内容**: 包含完整的 PVP 实现
  - `Common/pvp_common.c` - PVP 基础功能
  - `Common/PvPGameCommon.c` - PVP 游戏模式
  - `GameServerLib/gslPVP.c` - PVP 服务器实现
  - `GameServerLib/gslPvPGame.c` - PVP 游戏逻辑

### ✅ Core
- **位置**: `I:\wd1\Cryptic\Core\`
- **状态**: 存在
- **内容**: 核心系统代码

## 缺失的依赖

### ❌ libs
- **期望位置**: `I:\wd1\libs\`
- **状态**: 未找到
- **需要的库**（从项目文件分析）:
  - `libs/WorldLib/`
  - `libs/ServerLib/`
  - `libs/InputLib/`
  - `libs/EntityLib/`
  - `libs/AILib/`
  - `libs/ContentLib/`
  - `libs/HttpLib/`
  - `libs/Common/`
  - `libs/GraphicsLib/`
  - `libs/Renderers/`
  - `libs/UILib/`
  - `libs/PatchClientLib/`

### ❌ PropertySheets
- **期望位置**: `I:\wd1\PropertySheets\`
- **状态**: 未找到
- **需要的文件**:
  - `GeneralSettings.props`
  - `CrypticApplication.props`
  - `LinkerOptimizations.props`

### ❌ utilities
- **期望位置**: `I:\wd1\utilities\bin\structparser.exe`
- **状态**: 未找到
- **用途**: 预构建工具，用于生成自动代码

## 从 GameServerLib 项目分析

查看 `Cryptic/CrossRoads/GameServerLib/GameServerLib.vcxproj`，发现它也引用：
- `../../PropertySheets/GeneralSettings.props` (第29行)
- `../../utilities/bin/structparser` (第49行)
- `../../libs/` 多个库 (第43行)
- `../../Core/Common/` (第43行)

这说明这些依赖应该在项目根目录 `I:\wd1\` 下。

## 解决方案

### 方案 1: 创建符号链接（推荐）

以管理员身份运行：
```powershell
cd I:\wd1
.\Night\setup_dependencies.ps1
```

### 方案 2: 修改项目文件路径

如果无法创建符号链接，可以修改 `.vcxproj` 文件：
- 将 `../../CrossRoads` 改为 `../Cryptic/CrossRoads`
- 将 `../../core` 改为 `../Cryptic/Core`
- 其他路径也需要相应调整

### 方案 3: 查找完整项目结构

这些依赖可能在其他位置：
- 检查是否有其他项目目录
- 检查是否有压缩包或备份
- 联系项目维护者获取完整结构

## 建议

1. **优先尝试符号链接方案**
   - 运行 `setup_dependencies.ps1`（需要管理员权限）

2. **查找缺失的依赖**
   - 检查是否有其他项目目录包含这些文件
   - 检查是否有文档说明依赖位置

3. **如果依赖确实缺失**
   - 考虑从其他 Cryptic 项目复制
   - 或创建最小化的配置文件以满足编译需求

## 下一步行动

1. ✅ 已创建符号链接脚本
2. ⏳ 需要以管理员身份运行脚本
3. ⏳ 查找或创建缺失的 libs、PropertySheets、utilities
4. ⏳ 安装 Visual Studio 或 Build Tools
5. ⏳ 尝试编译项目

