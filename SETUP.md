# Night GameServer 依赖配置说明

## 当前状态

✅ **已找到的依赖：**
- `I:\wd1\Cryptic\CrossRoads` - PVP 功能完整实现
- `I:\wd1\Cryptic\Core` - 核心系统

❌ **缺失的依赖：**
- `I:\wd1\libs` - 各种库项目
- `I:\wd1\PropertySheets` - 项目属性表
- `I:\wd1\utilities` - 预构建工具（structparser）

## 项目期望的目录结构

项目期望在 `I:\wd1\` 目录下有：
```
I:\wd1\
├── CrossRoads\      (需要链接到 Cryptic\CrossRoads)
├── core\            (需要链接到 Cryptic\Core)
├── libs\            (缺失)
├── PropertySheets\  (缺失)
├── utilities\       (缺失)
└── Night\           (当前项目)
```

## 配置步骤

### 方法 1: 使用符号链接（推荐）

1. **以管理员身份运行 PowerShell**
   - 右键点击 PowerShell
   - 选择"以管理员身份运行"

2. **运行设置脚本**
   ```powershell
   cd I:\wd1\Night
   .\setup_dependencies.ps1
   ```

3. **手动创建其他链接**（如果需要）
   ```powershell
   # 以管理员身份运行
   cd I:\wd1
   
   # 创建 CrossRoads 链接
   New-Item -ItemType SymbolicLink -Path "CrossRoads" -Target "Cryptic\CrossRoads"
   
   # 创建 core 链接
   New-Item -ItemType SymbolicLink -Path "core" -Target "Cryptic\Core"
   ```

### 方法 2: 修改项目文件路径

如果无法创建符号链接，可以修改 `.vcxproj` 文件中的路径：
- 将 `../../CrossRoads` 改为 `../Cryptic/CrossRoads`
- 将 `../../core` 改为 `../Cryptic/Core`

### 方法 3: 复制目录（不推荐）

如果符号链接不可用，可以复制目录，但会占用更多空间。

## 查找缺失的依赖

### 查找 libs 目录
```powershell
# 在 Cryptic 目录下查找
Get-ChildItem "I:\wd1\Cryptic" -Recurse -Directory -Filter "libs" -ErrorAction SilentlyContinue
```

### 查找 PropertySheets
```powershell
# 查找 .props 文件
Get-ChildItem "I:\wd1\Cryptic" -Recurse -Filter "*.props" -ErrorAction SilentlyContinue | Select-Object Directory
```

### 查找 structparser
```powershell
# 查找 structparser.exe
Get-ChildItem "I:\wd1\Cryptic" -Recurse -Filter "structparser.exe" -ErrorAction SilentlyContinue
```

## 验证配置

运行以下命令检查：
```powershell
cd I:\wd1
Test-Path "CrossRoads"
Test-Path "core"
Test-Path "libs"
Test-Path "PropertySheets"
Test-Path "utilities\bin\structparser.exe"
```

## 下一步

配置完依赖后，可以尝试编译：
```powershell
cd I:\wd1\Night
.\build.ps1
```

