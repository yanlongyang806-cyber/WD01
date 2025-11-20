# 快速开始指南

## 一键设置依赖

### 方法 1: 直接运行（推荐）

直接双击运行 `setup_dependencies.ps1`，脚本会自动请求管理员权限。

或者右键点击文件，选择"使用 PowerShell 运行"。

### 方法 2: 手动以管理员身份运行

1. **右键点击 PowerShell**
2. **选择"以管理员身份运行"**
3. **运行脚本**：
   ```powershell
   cd I:\wd1\Night
   .\setup_dependencies.ps1
   ```

## 脚本功能

脚本会自动：
- ✅ 检测并请求管理员权限（如果需要）
- ✅ 创建 CrossRoads 符号链接
- ✅ 创建 core 符号链接
- ✅ 查找缺失的依赖位置
- ✅ 显示详细的配置状态

## 运行结果示例

```
=== Night GameServer Dependency Setup ===
Running with Administrator privileges

Setting up dependencies in: I:\wd1

Created: CrossRoads -> Cryptic\CrossRoads
Created: core -> Cryptic\Core

Summary:
  Created: 2
  Already exists: 0
  Failed: 0

Checking for other required directories...
WARNING: libs directory not found at: I:\wd1\libs
  Searching for libs...
  Found potential libs locations:
    - I:\wd1\Cryptic\...
```

## 常见问题

### Q: 脚本提示需要管理员权限？
A: 脚本会自动请求权限，点击"是"即可。如果失败，请手动以管理员身份运行 PowerShell。

### Q: 符号链接创建失败？
A: 确保：
- 以管理员身份运行
- 目标路径存在（Cryptic\CrossRoads 和 Cryptic\Core）
- 没有同名文件或目录占用路径

### Q: 如何验证符号链接创建成功？
```powershell
cd I:\wd1
Get-Item CrossRoads | Select-Object LinkType, Target
Get-Item core | Select-Object LinkType, Target
```

## 下一步

设置完依赖后：
1. 安装 Visual Studio 或 Build Tools
2. 运行 `build.ps1` 尝试编译
3. 查看 `DEPENDENCIES_REPORT.md` 了解缺失的依赖

