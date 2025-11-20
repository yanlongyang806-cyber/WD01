# GitHub Actions 工作流说明

## 工作流文件

### 1. `build.yml` - 基础编译工作流
- **触发**: Push 到 main/master 分支，Pull Request，手动触发
- **功能**: 
  - 检查依赖
  - 创建符号链接
  - 尝试编译 GameServer
  - 上传编译产物

### 2. `build-full.yml` - 完整编译检查
- **触发**: 手动触发，或特定文件变更
- **功能**:
  - 详细的项目结构检查
  - 完整的依赖检查
  - 详细编译日志
  - 错误分析

### 3. `ci.yml` - 持续集成验证
- **触发**: Push 和 Pull Request
- **功能**:
  - 验证项目文件结构
  - 检查关键文件
  - 验证脚本存在

## 使用方法

### 查看工作流状态

1. 访问 GitHub 仓库
2. 点击 "Actions" 标签
3. 查看工作流运行状态

### 手动触发编译

1. 进入 "Actions" 页面
2. 选择 "Build Full Project"
3. 点击 "Run workflow"
4. 选择分支并运行

## 注意事项

⚠️ **GitHub Actions 环境限制**:
- 无法访问本地文件系统（如 `I:\wd1\Cryptic`）
- 需要将依赖也提交到仓库，或使用其他方式
- 符号链接在 GitHub Actions 中可能不可用

## 建议

1. **将依赖也提交到仓库**
   - 创建 `dependencies` 分支
   - 或使用 Git LFS 存储大文件

2. **使用 Docker 编译**
   - 创建包含所有依赖的 Docker 镜像
   - 在容器中编译

3. **使用自托管 Runner**
   - 在本地机器上运行 GitHub Actions
   - 可以访问本地文件系统

