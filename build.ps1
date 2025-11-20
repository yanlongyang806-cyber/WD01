# Night GameServer Build Script
# Requires Visual Studio or MSBuild

Write-Host "=== Night GameServer Build Script ===" -ForegroundColor Green

# Find MSBuild
$msbuild = $null

# Try to find MSBuild
$vsPaths = @(
    "C:\Program Files (x86)\Microsoft Visual Studio\2022\Community\MSBuild\Current\Bin\MSBuild.exe",
    "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\MSBuild\Current\Bin\MSBuild.exe",
    "C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\MSBuild\15.0\Bin\MSBuild.exe",
    "C:\Program Files (x86)\MSBuild\14.0\Bin\MSBuild.exe"
)

foreach ($path in $vsPaths) {
    if (Test-Path $path) {
        $msbuild = $path
        Write-Host "Found MSBuild: $msbuild" -ForegroundColor Green
        break
    }
}

if (-not $msbuild) {
    Write-Host "Error: MSBuild.exe not found" -ForegroundColor Red
    Write-Host "Please install Visual Studio or Build Tools for Visual Studio" -ForegroundColor Yellow
    exit 1
}

# Check project file
$slnFile = "GameServer\NNOGameServer.sln"
if (-not (Test-Path $slnFile)) {
    Write-Host "Error: Solution file not found: $slnFile" -ForegroundColor Red
    exit 1
}

Write-Host "`nStarting build..." -ForegroundColor Cyan
Write-Host "Solution: $slnFile" -ForegroundColor Cyan
Write-Host "Configuration: Debug" -ForegroundColor Cyan
Write-Host "Platform: Win32`n" -ForegroundColor Cyan

# Build project
& $msbuild $slnFile `
    /p:Configuration=Debug `
    /p:Platform=Win32 `
    /t:Build `
    /v:minimal `
    /nologo

if ($LASTEXITCODE -eq 0) {
    Write-Host "`nBuild succeeded!" -ForegroundColor Green
} else {
    Write-Host "`nBuild failed! Exit code: $LASTEXITCODE" -ForegroundColor Red
    Write-Host "`nPossible reasons:" -ForegroundColor Yellow
    Write-Host "1. Missing dependency projects (CrossRoads, libs, core)" -ForegroundColor Yellow
    Write-Host "2. Missing PropertySheets configuration files" -ForegroundColor Yellow
    Write-Host "3. Missing structparser pre-build tool" -ForegroundColor Yellow
    Write-Host "4. Missing required header files and libraries" -ForegroundColor Yellow
}
