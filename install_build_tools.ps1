# Install Build Tools Helper Script
# This script helps you install Visual Studio Build Tools

Write-Host "=== Visual Studio Build Tools 安装助手 ===" -ForegroundColor Green
Write-Host ""

Write-Host "选项 1: 下载 Visual Studio Community（推荐）" -ForegroundColor Cyan
Write-Host "  - 包含完整的 IDE" -ForegroundColor Gray
Write-Host "  - 下载地址: https://visualstudio.microsoft.com/" -ForegroundColor Yellow
Write-Host "  - 安装时选择: '使用 C++ 的桌面开发'" -ForegroundColor Gray
Write-Host ""

Write-Host "选项 2: 下载 Build Tools（轻量级）" -ForegroundColor Cyan
Write-Host "  - 只包含编译工具，不包含 IDE" -ForegroundColor Gray
Write-Host "  - 下载地址: https://visualstudio.microsoft.com/downloads/#build-tools-for-visual-studio-2022" -ForegroundColor Yellow
Write-Host "  - 安装时选择: 'C++ 生成工具'" -ForegroundColor Gray
Write-Host ""

Write-Host "选项 3: 使用 Chocolatey 安装（如果已安装 Chocolatey）" -ForegroundColor Cyan
Write-Host "  choco install visualstudio2022buildtools --package-parameters `"--add Microsoft.VisualStudio.Workload.VCTools`"" -ForegroundColor Yellow
Write-Host ""

# Check if Chocolatey is available
$chocoAvailable = Get-Command choco -ErrorAction SilentlyContinue
if ($chocoAvailable) {
    Write-Host "检测到 Chocolatey 已安装" -ForegroundColor Green
    Write-Host ""
    $install = Read-Host "是否使用 Chocolatey 安装 Build Tools? (Y/N)"
    if ($install -eq "Y" -or $install -eq "y") {
        Write-Host "正在安装..." -ForegroundColor Cyan
        choco install visualstudio2022buildtools --package-parameters "--add Microsoft.VisualStudio.Workload.VCTools" -y
    }
} else {
    Write-Host "未检测到 Chocolatey" -ForegroundColor Yellow
    Write-Host "可以访问 https://chocolatey.org/ 安装 Chocolatey" -ForegroundColor Gray
}

Write-Host ""
Write-Host "安装完成后，运行以下命令编译项目:" -ForegroundColor Cyan
Write-Host "  cd I:\wd1\Night" -ForegroundColor Yellow
Write-Host "  .\build.ps1" -ForegroundColor Yellow
Write-Host ""

# Try to open download page
$openPage = Read-Host "是否打开 Visual Studio 下载页面? (Y/N)"
if ($openPage -eq "Y" -or $openPage -eq "y") {
    Start-Process "https://visualstudio.microsoft.com/downloads/"
}

