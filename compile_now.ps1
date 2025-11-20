# Quick Compile Script
# Attempts to compile the project with available tools

Write-Host "=== 快速编译脚本 ===" -ForegroundColor Green
Write-Host ""

# Check dependencies first
Write-Host "检查依赖..." -ForegroundColor Cyan
$depsOk = $true

if (-not (Test-Path "I:\wd1\CrossRoads")) {
    Write-Host "  ❌ CrossRoads 未找到" -ForegroundColor Red
    Write-Host "     运行: .\setup_dependencies.ps1" -ForegroundColor Yellow
    $depsOk = $false
} else {
    Write-Host "  ✅ CrossRoads 已配置" -ForegroundColor Green
}

if (-not (Test-Path "I:\wd1\core")) {
    Write-Host "  ❌ core 未找到" -ForegroundColor Red
    Write-Host "     运行: .\setup_dependencies.ps1" -ForegroundColor Yellow
    $depsOk = $false
} else {
    Write-Host "  ✅ core 已配置" -ForegroundColor Green
}

if (-not $depsOk) {
    Write-Host ""
    Write-Host "请先配置依赖！" -ForegroundColor Red
    exit 1
}

Write-Host ""

# Try to find MSBuild
Write-Host "查找编译工具..." -ForegroundColor Cyan
$msbuild = $null

$vsPaths = @(
    "C:\Program Files\Microsoft Visual Studio\2022\Community\MSBuild\Current\Bin\MSBuild.exe",
    "C:\Program Files\Microsoft Visual Studio\2022\Professional\MSBuild\Current\Bin\MSBuild.exe",
    "C:\Program Files\Microsoft Visual Studio\2022\Enterprise\MSBuild\Current\Bin\MSBuild.exe",
    "C:\Program Files (x86)\Microsoft Visual Studio\2022\Community\MSBuild\Current\Bin\MSBuild.exe",
    "C:\Program Files (x86)\Microsoft Visual Studio\2022\Professional\MSBuild\Current\Bin\MSBuild.exe",
    "C:\Program Files (x86)\Microsoft Visual Studio\2022\Enterprise\MSBuild\Current\Bin\MSBuild.exe",
    "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\MSBuild\Current\Bin\MSBuild.exe",
    "C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\MSBuild\15.0\Bin\MSBuild.exe",
    "C:\Program Files (x86)\MSBuild\14.0\Bin\MSBuild.exe"
)

foreach ($path in $vsPaths) {
    if (Test-Path $path) {
        $msbuild = $path
        Write-Host "  ✅ 找到 MSBuild: $msbuild" -ForegroundColor Green
        break
    }
}

if (-not $msbuild) {
    Write-Host "  ❌ 未找到 MSBuild" -ForegroundColor Red
    Write-Host ""
    Write-Host "请安装 Visual Studio 或 Build Tools:" -ForegroundColor Yellow
    Write-Host "  1. 运行: .\install_build_tools.ps1" -ForegroundColor Cyan
    Write-Host "  2. 或访问: https://visualstudio.microsoft.com/" -ForegroundColor Cyan
    Write-Host ""
    exit 1
}

Write-Host ""

# Check project file
$slnFile = "GameServer\NNOGameServer.sln"
if (-not (Test-Path $slnFile)) {
    Write-Host "错误: 未找到解决方案文件: $slnFile" -ForegroundColor Red
    exit 1
}

Write-Host "开始编译..." -ForegroundColor Cyan
Write-Host "  解决方案: $slnFile" -ForegroundColor Gray
Write-Host "  配置: Debug" -ForegroundColor Gray
Write-Host "  平台: Win32" -ForegroundColor Gray
Write-Host ""

# Compile
& $msbuild $slnFile `
    /p:Configuration=Debug `
    /p:Platform=Win32 `
    /t:Build `
    /v:minimal `
    /nologo

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "✅ 编译成功!" -ForegroundColor Green
    Write-Host ""
    Write-Host "输出文件位置:" -ForegroundColor Cyan
    Write-Host "  检查 GameServer\Debug\ 或 GameServer\bin\ 目录" -ForegroundColor Gray
} else {
    Write-Host ""
    Write-Host "❌ 编译失败! 错误代码: $LASTEXITCODE" -ForegroundColor Red
    Write-Host ""
    Write-Host "可能的原因:" -ForegroundColor Yellow
    Write-Host "  1. 缺少依赖项目 (libs, PropertySheets)" -ForegroundColor Gray
    Write-Host "  2. 缺少 structparser.exe 预构建工具" -ForegroundColor Gray
    Write-Host "  3. 缺少必要的头文件和库文件" -ForegroundColor Gray
    Write-Host ""
    Write-Host "查看详细错误信息，或运行:" -ForegroundColor Cyan
    Write-Host "  .\build.ps1" -ForegroundColor Yellow
}

