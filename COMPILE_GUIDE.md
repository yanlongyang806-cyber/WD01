# 编译指南

## 当前状态

❌ **未找到 MSBuild**
- 需要安装 Visual Studio 或 Build Tools

## 方法 1: 安装 Visual Studio（推荐）

### 下载和安装

1. **下载 Visual Studio**
   - 访问：https://visualstudio.microsoft.com/
   - 下载 Visual Studio Community（免费）

2. **安装时选择工作负载**
   - ✅ 使用 C++ 的桌面开发
   - ✅ Windows 10/11 SDK
   - ✅ MSVC v143 编译器工具集

3. **安装完成后**
   ```powershell
   cd I:\wd1\Night
   .\build.ps1
   ```

### 使用 Visual Studio IDE

1. **打开解决方案**
   - 双击 `MasterSolution\NNOMasterSolution.sln`
   - 或 `GameServer\NNOGameServer.sln`

2. **选择配置**
   - 配置：Debug 或 Full Debug
   - 平台：Win32

3. **生成解决方案**
   - 菜单：生成 → 生成解决方案
   - 或按 `Ctrl+Shift+B`

## 方法 2: 安装 Build Tools（轻量级）

### 下载 Build Tools

1. **下载 Visual Studio Build Tools**
   - 访问：https://visualstudio.microsoft.com/downloads/#build-tools-for-visual-studio-2022
   - 下载 "Build Tools for Visual Studio 2022"

2. **安装时选择**
   - ✅ C++ 生成工具
   - ✅ Windows 10/11 SDK
   - ✅ MSVC v143 编译器工具集

3. **安装完成后运行**
   ```powershell
   cd I:\wd1\Night
   .\build.ps1
   ```

## 方法 3: 使用 Visual Studio Developer Command Prompt

如果已安装 Visual Studio：

1. **打开 Developer Command Prompt**
   - 开始菜单 → Visual Studio → Developer Command Prompt

2. **运行编译**
   ```cmd
   cd I:\wd1\Night\GameServer
   msbuild NNOGameServer.sln /p:Configuration=Debug /p:Platform=Win32
   ```

## 编译前准备

### 1. 配置依赖（必需）

以管理员身份运行：
```powershell
cd I:\wd1\Night
.\setup_dependencies.ps1
```

这会创建必要的符号链接。

### 2. 检查依赖

确保以下目录存在：
- ✅ `I:\wd1\CrossRoads` (符号链接到 Cryptic\CrossRoads)
- ✅ `I:\wd1\core` (符号链接到 Cryptic\Core)
- ⚠️ `I:\wd1\libs` (可能需要查找或创建)
- ⚠️ `I:\wd1\PropertySheets` (可能需要查找或创建)
- ⚠️ `I:\wd1\utilities\bin\structparser.exe` (可能需要查找)

## 编译步骤

### 使用脚本编译（推荐）

```powershell
cd I:\wd1\Night
.\build.ps1
```

### 手动编译

```powershell
# 找到 MSBuild 路径（通常在以下位置之一）
$msbuild = "C:\Program Files (x86)\Microsoft Visual Studio\2022\Community\MSBuild\Current\Bin\MSBuild.exe"

# 编译
& $msbuild "GameServer\NNOGameServer.sln" /p:Configuration=Debug /p:Platform=Win32
```

## 可能遇到的错误

### 错误 1: 找不到 PropertySheets

**解决方案**：
- 查找 `.props` 文件位置
- 修改 `.vcxproj` 文件中的路径
- 或创建 PropertySheets 目录并复制文件

### 错误 2: 找不到 structparser.exe

**解决方案**：
- 查找 structparser.exe 位置
- 创建 `utilities\bin\` 目录
- 复制 structparser.exe 到该目录

### 错误 3: 找不到头文件

**解决方案**：
- 检查依赖目录是否正确链接
- 检查 `.vcxproj` 中的包含路径
- 确保所有依赖库都存在

### 错误 4: 链接错误

**解决方案**：
- 确保所有依赖项目都已编译
- 检查库文件路径
- 确保 DLL 文件在正确位置

## 快速检查清单

在编译前检查：

- [ ] 已安装 Visual Studio 或 Build Tools
- [ ] 已运行 `setup_dependencies.ps1` 配置依赖
- [ ] CrossRoads 和 core 符号链接已创建
- [ ] 已查找或创建 libs 目录
- [ ] 已查找或创建 PropertySheets 目录
- [ ] 已查找或创建 utilities\bin\structparser.exe

## 获取帮助

如果遇到问题：
1. 查看 `BUILD.md` 详细说明
2. 查看 `DEPENDENCIES_REPORT.md` 依赖信息
3. 检查编译错误日志
4. 确保所有依赖都正确配置

