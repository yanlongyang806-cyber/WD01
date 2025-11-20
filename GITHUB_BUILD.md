# GitHub Actions 编译完整指南

## ✅ 已创建的工作流

### 1. `build.yml` - 主要编译工作流（已优化）
- **触发**: 自动（Push/PR）或手动
- **功能**:
  - ✅ 智能依赖检测（多个路径）
  - ✅ 自动创建符号链接
  - ✅ 详细编译日志
  - ✅ 错误分析
  - ✅ 自动上传编译产物和日志

### 2. `build-full.yml` - 完整编译检查
- **触发**: 手动或特定文件变更
- **功能**: 详细的项目检查和完整日志

### 3. `build-smart.yml` - 智能多项目编译
- **触发**: 手动或 GameServer 变更
- **功能**: 并行编译多个项目（GameServer、AppServer、GameClient）

### 4. `prepare-dependencies.yml` - 依赖准备
- **触发**: 手动
- **功能**: 检查和准备依赖结构

### 5. `ci.yml` - 持续集成验证
- **触发**: 每次 Push/PR
- **功能**: 验证项目文件完整性

## 🚀 快速开始

### 方法 1: 自动编译（推荐）

推送代码后自动运行：

```powershell
git push
```

访问：https://github.com/yanlongyang806-cyber/WD01/actions

### 方法 2: 手动触发

1. 访问：https://github.com/yanlongyang806-cyber/WD01
2. 点击 **"Actions"** 标签
3. 选择工作流：
   - **"Build Night GameServer"** - 主要编译
   - **"Smart Build"** - 多项目编译
   - **"Build Full Project"** - 完整检查
4. 点击 **"Run workflow"**
5. 选择分支并运行

## 📊 工作流功能对比

| 工作流 | 自动触发 | 手动触发 | 依赖处理 | 日志详细度 |
|--------|---------|---------|---------|-----------|
| build.yml | ✅ | ✅ | ✅ 智能检测 | 详细 |
| build-full.yml | ❌ | ✅ | ✅ 完整检查 | 非常详细 |
| build-smart.yml | ✅ | ✅ | ⚠️ 基础 | 标准 |
| prepare-dependencies.yml | ❌ | ✅ | ✅ 专门处理 | 标准 |
| ci.yml | ✅ | ❌ | ❌ 仅验证 | 简单 |

## 🔍 优化功能

### build.yml 的新功能

1. **智能依赖检测**
   - 检查多个可能的路径
   - 自动识别依赖位置
   - 详细报告缺失依赖

2. **自动链接创建**
   - 尝试创建符号链接
   - 如果失败，提供替代方案

3. **详细编译分析**
   - 分析编译日志
   - 统计错误和警告
   - 显示前 10 个错误

4. **智能产物查找**
   - 检查多个可能的输出目录
   - 自动上传找到的产物

5. **完整日志保存**
   - 保存详细编译日志
   - 30 天保留期
   - 便于问题诊断

## 📥 查看编译结果

### 在工作流页面

1. 访问 Actions 页面
2. 点击运行的工作流
3. 查看每个步骤的输出
4. 下载编译产物和日志

### 下载编译产物

1. 在工作流运行页面
2. 滚动到底部
3. 在 "Artifacts" 部分下载：
   - `build-outputs` - 编译产物
   - `build-log` - 详细日志

## ⚠️ 依赖问题处理

### 如果编译失败（依赖缺失）

工作流会：
- ✅ 检测所有依赖
- ✅ 显示缺失的依赖
- ✅ 提供详细的错误信息
- ✅ 保存完整日志供分析

### 解决方案

1. **将依赖添加到仓库**
   ```powershell
   # 在仓库根目录添加依赖
   git add Cryptic/
   git commit -m "Add dependencies"
   git push
   ```

2. **使用 Git LFS（大文件）**
   ```powershell
   git lfs install
   git lfs track "*.dll"
   git lfs track "*.lib"
   git add .gitattributes
   git commit -m "Add LFS tracking"
   ```

3. **配置自托管 Runner**
   - 在本地机器运行 GitHub Actions
   - 可以访问本地文件系统

## 📈 工作流状态

- ✅ **已创建**: 5 个工作流文件
- ✅ **已优化**: build.yml 增强功能
- ✅ **已推送**: 所有文件已推送到 GitHub

## 🎯 下一步

1. **推送代码触发编译**
   ```powershell
   git push
   ```

2. **查看编译结果**
   - 访问 Actions 页面
   - 查看工作流运行状态

3. **根据结果调整**
   - 如果依赖缺失，添加依赖
   - 如果编译错误，查看日志
   - 优化工作流配置

## 🔗 相关链接

- 工作流页面: https://github.com/yanlongyang806-cyber/WD01/actions
- 仓库主页: https://github.com/yanlongyang806-cyber/WD01
- 详细文档: `GITHUB_ACTIONS.md`

