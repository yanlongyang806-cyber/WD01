# Setup Dependencies Script
# This script creates symbolic links to required dependencies
# NOTE: Requires Administrator privileges

Write-Host "=== Night GameServer Dependency Setup ===" -ForegroundColor Green
Write-Host ""

# Check if running as administrator
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if (-not $isAdmin) {
    Write-Host "ERROR: This script requires Administrator privileges!" -ForegroundColor Red
    Write-Host "Please run PowerShell as Administrator and try again." -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Right-click PowerShell -> Run as Administrator" -ForegroundColor Cyan
    exit 1
}

$basePath = "I:\wd1"
Set-Location $basePath

Write-Host "Setting up dependencies in: $basePath" -ForegroundColor Cyan
Write-Host ""

# Create symbolic links
$links = @(
    @{Name="CrossRoads"; Target="Cryptic\CrossRoads"},
    @{Name="core"; Target="Cryptic\Core"}
)

foreach ($link in $links) {
    $linkPath = Join-Path $basePath $link.Name
    $targetPath = Join-Path $basePath $link.Target
    
    if (Test-Path $linkPath) {
        Write-Host "Already exists: $($link.Name)" -ForegroundColor Yellow
    } elseif (Test-Path $targetPath) {
        try {
            New-Item -ItemType SymbolicLink -Path $linkPath -Target $targetPath -Force | Out-Null
            Write-Host "Created: $($link.Name) -> $($link.Target)" -ForegroundColor Green
        } catch {
            Write-Host "Failed to create: $($link.Name) - $_" -ForegroundColor Red
        }
    } else {
        Write-Host "Target not found: $($link.Target)" -ForegroundColor Red
    }
}

Write-Host ""
Write-Host "Checking for other required directories..." -ForegroundColor Cyan

# Check for libs directory
$libsPath = Join-Path $basePath "libs"
if (-not (Test-Path $libsPath)) {
    Write-Host "WARNING: libs directory not found at: $libsPath" -ForegroundColor Yellow
    Write-Host "  You may need to create this directory or find where libraries are located" -ForegroundColor Yellow
}

# Check for PropertySheets directory
$propsPath = Join-Path $basePath "PropertySheets"
if (-not (Test-Path $propsPath)) {
    Write-Host "WARNING: PropertySheets directory not found at: $propsPath" -ForegroundColor Yellow
    Write-Host "  You may need to create this directory or find where property sheets are located" -ForegroundColor Yellow
}

# Check for utilities directory
$utilsPath = Join-Path $basePath "utilities"
if (-not (Test-Path $utilsPath)) {
    Write-Host "WARNING: utilities directory not found at: $utilsPath" -ForegroundColor Yellow
    Write-Host "  This contains structparser.exe needed for pre-build" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "Setup complete!" -ForegroundColor Green

