# Night GameServer 编译脚本
# 需要 Visual Studio 或 MSBuild

Write-Host "=== Night GameServer 编译脚本 ===" -ForegroundColor Green

# 检查 MSBuild
$msbuild = $null

# 尝试查找 MSBuild
$vsPaths = @(
    "C:\Program Files (x86)\Microsoft Visual Studio\2022\Community\MSBuild\Current\Bin\MSBuild.exe",
    "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\MSBuild\Current\Bin\MSBuild.exe",
    "C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\MSBuild\15.0\Bin\MSBuild.exe",
    "C:\Program Files (x86)\MSBuild\14.0\Bin\MSBuild.exe"
)

foreach ($path in $vsPaths) {
    if (Test-Path $path) {
        $msbuild = $path
        Write-Host "找到 MSBuild: $msbuild" -ForegroundColor Green
        break
    }
}

if (-not $msbuild) {
    Write-Host "错误: 未找到 MSBuild.exe" -ForegroundColor Red
    Write-Host "请安装 Visual Studio 或 Build Tools for Visual Studio" -ForegroundColor Yellow
    exit 1
}

# 检查项目文件
$slnFile = "GameServer\NNOGameServer.sln"
if (-not (Test-Path $slnFile)) {
    Write-Host "错误: 未找到解决方案文件: $slnFile" -ForegroundColor Red
    exit 1
}

Write-Host "`n开始编译..." -ForegroundColor Cyan
Write-Host "解决方案: $slnFile" -ForegroundColor Cyan
Write-Host "配置: Debug" -ForegroundColor Cyan
Write-Host "平台: Win32`n" -ForegroundColor Cyan

# 编译项目
& $msbuild $slnFile `
    /p:Configuration=Debug `
    /p:Platform=Win32 `
    /t:Build `
    /v:minimal `
    /nologo

if ($LASTEXITCODE -eq 0) {
    Write-Host "`n编译成功!" -ForegroundColor Green
} else {
    Write-Host "`n编译失败! 错误代码: $LASTEXITCODE" -ForegroundColor Red
    Write-Host "`n可能的原因:" -ForegroundColor Yellow
    Write-Host "1. 缺少依赖项目 (CrossRoads, libs, core)" -ForegroundColor Yellow
    Write-Host "2. 缺少 PropertySheets 配置文件" -ForegroundColor Yellow
    Write-Host "3. 缺少 structparser 预构建工具" -ForegroundColor Yellow
    Write-Host "4. 缺少必要的头文件和库文件" -ForegroundColor Yellow
}

