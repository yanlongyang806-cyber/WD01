# GitHub Actions 编译说明

## ✅ 已创建的工作流

已创建 3 个 GitHub Actions 工作流文件：

1. **`build.yml`** - 基础编译工作流
2. **`build-full.yml`** - 完整编译检查（手动触发）
3. **`ci.yml`** - 持续集成验证

## 如何使用

### 方法 1: 自动触发

当你推送代码到 GitHub 时，工作流会自动运行：

```powershell
git add .
git commit -m "你的更改"
git push
```

然后访问：https://github.com/yanlongyang806-cyber/WD01/actions

### 方法 2: 手动触发

1. 访问 GitHub 仓库：https://github.com/yanlongyang806-cyber/WD01
2. 点击 "Actions" 标签
3. 选择 "Build Full Project" 工作流
4. 点击 "Run workflow" 按钮
5. 选择分支（main）并运行

## 工作流功能

### build.yml
- ✅ 自动检查依赖
- ✅ 尝试创建符号链接
- ✅ 编译 GameServer 项目
- ✅ 上传编译产物（如果成功）

### build-full.yml
- ✅ 详细的项目结构检查
- ✅ 完整的依赖验证
- ✅ 详细编译日志
- ✅ 错误分析和报告

### ci.yml
- ✅ 验证项目文件完整性
- ✅ 检查关键文件存在
- ✅ 验证脚本文件

## ⚠️ 重要限制

GitHub Actions 环境**无法访问本地文件系统**：
- ❌ 无法访问 `I:\wd1\Cryptic\CrossRoads`
- ❌ 无法访问 `I:\wd1\Cryptic\Core`
- ❌ 无法访问本地依赖目录

## 解决方案

### 方案 1: 将依赖提交到仓库（推荐）

如果依赖文件不太大：

```powershell
# 将依赖目录添加到仓库
cd I:\wd1
git init  # 如果还没有初始化
git add Cryptic/CrossRoads
git add Cryptic/Core
git commit -m "Add dependencies"
git push
```

### 方案 2: 使用 Git LFS（大文件）

如果依赖文件很大：

```powershell
# 安装 Git LFS
git lfs install

# 跟踪大文件
git lfs track "*.dll"
git lfs track "*.lib"
git lfs track "*.pdb"

# 添加并提交
git add .gitattributes
git add Cryptic/
git commit -m "Add dependencies with LFS"
git push
```

### 方案 3: 使用自托管 Runner

在本地机器上运行 GitHub Actions：

1. 在 GitHub 仓库设置中配置自托管 Runner
2. 在本地安装 Runner
3. 工作流会在本地运行，可以访问本地文件

### 方案 4: 修改工作流使用 Docker

创建包含所有依赖的 Docker 镜像，在容器中编译。

## 当前状态

✅ **工作流已创建并推送**
- 文件位置：`.github/workflows/`
- 已推送到 GitHub

⚠️ **需要配置依赖**
- 选择上述方案之一
- 或修改工作流以适应你的环境

## 查看工作流运行

访问：https://github.com/yanlongyang806-cyber/WD01/actions

## 下一步

1. **推送代码触发工作流**
   ```powershell
   git push
   ```

2. **查看运行结果**
   - 访问 Actions 页面
   - 查看工作流运行状态

3. **根据错误信息调整**
   - 如果依赖缺失，使用上述方案之一
   - 修改工作流配置

