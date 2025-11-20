# 修复编译问题指南

## 问题：编译没有生成输出文件

如果 GitHub Actions 工作流运行成功，但没有生成编译产物，通常是因为：

## 常见原因

### 1. 依赖缺失 ❌

**症状**：
- 工作流显示成功
- 但没有编译产物
- 日志显示找不到头文件或库文件

**解决方案**：

#### 方案 A: 将依赖添加到仓库

```powershell
# 在仓库根目录
cd I:\wd1
git init  # 如果还没有初始化
git add Cryptic/CrossRoads
git add Cryptic/Core
git commit -m "Add dependencies"
git push
```

#### 方案 B: 使用 Git LFS（大文件）

```powershell
# 安装 Git LFS
git lfs install

# 跟踪大文件
git lfs track "*.dll"
git lfs track "*.lib"
git lfs track "*.pdb"

# 添加依赖
git add .gitattributes
git add Cryptic/
git commit -m "Add dependencies with LFS"
git push
```

### 2. PropertySheets 缺失 ❌

**症状**：
- 错误：`The imported project "..\..\PropertySheets\xxx.props" was not found`

**解决方案**：

1. **查找 PropertySheets**
   ```powershell
   Get-ChildItem "I:\wd1\Cryptic" -Recurse -Filter "*.props" | Select-Object DirectoryName
   ```

2. **创建目录并复制文件**
   ```powershell
   mkdir I:\wd1\PropertySheets
   # 复制找到的 .props 文件
   ```

3. **提交到仓库**
   ```powershell
   git add PropertySheets/
   git commit -m "Add PropertySheets"
   git push
   ```

### 3. structparser.exe 缺失 ❌

**症状**：
- 预构建步骤失败
- 错误：找不到 structparser.exe

**解决方案**：

1. **查找 structparser.exe**
   ```powershell
   Get-ChildItem "I:\wd1" -Recurse -Filter "structparser.exe"
   ```

2. **创建目录结构**
   ```powershell
   mkdir I:\wd1\utilities\bin
   # 复制 structparser.exe
   ```

3. **或修改项目文件跳过预构建**
   - 编辑 `.vcxproj` 文件
   - 注释掉 PreBuildEvent

### 4. libs 目录缺失 ❌

**症状**：
- 链接错误
- 找不到库文件

**解决方案**：

1. **查找 libs 目录**
   ```powershell
   Get-ChildItem "I:\wd1\Cryptic" -Recurse -Directory -Filter "*lib*"
   ```

2. **创建符号链接或复制**
   ```powershell
   # 如果找到，创建链接
   New-Item -ItemType SymbolicLink -Path "I:\wd1\libs" -Target "找到的路径"
   ```

## 快速诊断

### 检查工作流日志

1. 访问：https://github.com/yanlongyang806-cyber/WD01/actions
2. 点击最新的工作流运行
3. 查看 "Build GameServer" 步骤
4. 下载 `build-log` 文件
5. 查找错误信息

### 常见错误模式

```
error C1083: Cannot open include file: 'xxx.h'
→ 缺少头文件，需要添加依赖

error LNK2019: unresolved external symbol
→ 缺少库文件，需要添加 libs

error MSB4019: The imported project was not found
→ 缺少 PropertySheets，需要添加配置文件

error: The system cannot find the file specified
→ 缺少工具（如 structparser.exe）
```

## 推荐的解决方案

### 方案 1: 完整依赖提交（如果文件不太大）

```powershell
cd I:\wd1
git init
git add Cryptic/CrossRoads
git add Cryptic/Core
git add PropertySheets/  # 如果找到
git add utilities/       # 如果找到
git commit -m "Add all dependencies"
git push
```

### 方案 2: 使用 Git LFS（大文件）

```powershell
git lfs install
git lfs track "*.dll"
git lfs track "*.lib"
git lfs track "*.pdb"
git lfs track "*.exe"
git add .gitattributes
git add Cryptic/
git commit -m "Add dependencies with LFS"
git push
```

### 方案 3: 配置自托管 Runner

在本地机器上运行 GitHub Actions，可以访问本地文件系统。

## 下一步

1. **查看最新的工作流日志**
   - 下载 `build-log` 文件
   - 分析具体错误

2. **根据错误添加缺失的依赖**

3. **重新推送触发编译**

4. **验证编译产物**

## 需要帮助？

如果遇到具体错误，可以：
1. 复制错误信息
2. 查看 `build-log` 文件
3. 根据错误信息添加相应的依赖

