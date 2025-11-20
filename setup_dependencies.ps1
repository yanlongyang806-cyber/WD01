# Setup Dependencies Script
# This script creates symbolic links to required dependencies
# NOTE: Requires Administrator privileges

# Check if running as administrator, if not, restart with elevation
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if (-not $isAdmin) {
    Write-Host "This script requires Administrator privileges!" -ForegroundColor Yellow
    Write-Host "Attempting to restart with elevated permissions..." -ForegroundColor Cyan
    Write-Host ""
    
    # Get the script path
    $scriptPath = $MyInvocation.MyCommand.Path
    $scriptDir = Split-Path -Parent $scriptPath
    
    # Restart with elevation
    Start-Process powershell.exe -Verb RunAs -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$scriptPath`"" -Wait
    
    exit
}

Write-Host "=== Night GameServer Dependency Setup ===" -ForegroundColor Green
Write-Host "Running with Administrator privileges" -ForegroundColor Green
Write-Host ""

$basePath = "I:\wd1"
Set-Location $basePath

Write-Host "Setting up dependencies in: $basePath" -ForegroundColor Cyan
Write-Host ""

# Create symbolic links
$links = @(
    @{Name="CrossRoads"; Target="Cryptic\CrossRoads"},
    @{Name="core"; Target="Cryptic\Core"}
)

$createdLinks = 0
$existingLinks = 0
$failedLinks = 0

foreach ($link in $links) {
    $linkPath = Join-Path $basePath $link.Name
    $targetPath = Join-Path $basePath $link.Target
    
    if (Test-Path $linkPath) {
        $linkType = (Get-Item $linkPath).LinkType
        if ($linkType -eq "SymbolicLink") {
            Write-Host "Symbolic link already exists: $($link.Name)" -ForegroundColor Yellow
            $existingLinks++
        } else {
            Write-Host "Path exists but is not a symbolic link: $($link.Name)" -ForegroundColor Yellow
            Write-Host "  Consider removing it first if you want to create a link" -ForegroundColor Yellow
            $existingLinks++
        }
    } elseif (Test-Path $targetPath) {
        try {
            New-Item -ItemType SymbolicLink -Path $linkPath -Target $targetPath -Force | Out-Null
            Write-Host "Created: $($link.Name) -> $($link.Target)" -ForegroundColor Green
            $createdLinks++
        } catch {
            Write-Host "Failed to create: $($link.Name) - $_" -ForegroundColor Red
            $failedLinks++
        }
    } else {
        Write-Host "Target not found: $($link.Target)" -ForegroundColor Red
        Write-Host "  Cannot create link for: $($link.Name)" -ForegroundColor Red
        $failedLinks++
    }
}

Write-Host ""
Write-Host "Summary:" -ForegroundColor Cyan
Write-Host "  Created: $createdLinks" -ForegroundColor Green
Write-Host "  Already exists: $existingLinks" -ForegroundColor Yellow
Write-Host "  Failed: $failedLinks" -ForegroundColor $(if ($failedLinks -gt 0) { "Red" } else { "Green" })

Write-Host ""
Write-Host "Checking for other required directories..." -ForegroundColor Cyan

# Check for libs directory
$libsPath = Join-Path $basePath "libs"
if (-not (Test-Path $libsPath)) {
    Write-Host "WARNING: libs directory not found at: $libsPath" -ForegroundColor Yellow
    Write-Host "  You may need to create this directory or find where libraries are located" -ForegroundColor Yellow
    
    # Try to find libs in Cryptic directory
    Write-Host "  Searching for libs..." -ForegroundColor Cyan
    $crypticLibs = Get-ChildItem "I:\wd1\Cryptic" -Recurse -Directory -Filter "*lib*" -ErrorAction SilentlyContinue -Depth 2 | Select-Object -First 3
    if ($crypticLibs) {
        Write-Host "  Found potential libs locations:" -ForegroundColor Cyan
        foreach ($lib in $crypticLibs) {
            Write-Host "    - $($lib.FullName)" -ForegroundColor Gray
        }
    } else {
        Write-Host "  No libs directories found in Cryptic" -ForegroundColor Gray
    }
} else {
    Write-Host "Found: libs directory at $libsPath" -ForegroundColor Green
}

# Check for PropertySheets directory
$propsPath = Join-Path $basePath "PropertySheets"
if (-not (Test-Path $propsPath)) {
    Write-Host "WARNING: PropertySheets directory not found at: $propsPath" -ForegroundColor Yellow
    Write-Host "  You may need to create this directory or find where property sheets are located" -ForegroundColor Yellow
    
    # Try to find .props files
    Write-Host "  Searching for .props files..." -ForegroundColor Cyan
    $propsFiles = Get-ChildItem "I:\wd1\Cryptic" -Recurse -Filter "*.props" -ErrorAction SilentlyContinue | Select-Object -First 3
    if ($propsFiles) {
        Write-Host "  Found .props files at:" -ForegroundColor Cyan
        foreach ($prop in $propsFiles) {
            Write-Host "    - $($prop.DirectoryName)" -ForegroundColor Gray
        }
    } else {
        Write-Host "  No .props files found" -ForegroundColor Gray
    }
} else {
    Write-Host "Found: PropertySheets directory at $propsPath" -ForegroundColor Green
}

# Check for utilities directory
$utilsPath = Join-Path $basePath "utilities"
if (-not (Test-Path $utilsPath)) {
    Write-Host "WARNING: utilities directory not found at: $utilsPath" -ForegroundColor Yellow
    Write-Host "  This contains structparser.exe needed for pre-build" -ForegroundColor Yellow
    
    # Try to find structparser
    Write-Host "  Searching for structparser.exe..." -ForegroundColor Cyan
    $structparser = Get-ChildItem "I:\wd1" -Recurse -Filter "structparser.exe" -ErrorAction SilentlyContinue | Select-Object -First 1
    if ($structparser) {
        Write-Host "  Found structparser.exe at: $($structparser.DirectoryName)" -ForegroundColor Cyan
    } else {
        Write-Host "  structparser.exe not found" -ForegroundColor Gray
    }
} else {
    $structparserPath = Join-Path $utilsPath "bin\structparser.exe"
    if (Test-Path $structparserPath) {
        Write-Host "Found: structparser.exe at $structparserPath" -ForegroundColor Green
    } else {
        Write-Host "WARNING: utilities directory exists but structparser.exe not found" -ForegroundColor Yellow
    }
}

Write-Host ""
Write-Host "Setup complete!" -ForegroundColor Green
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Cyan
Write-Host "  1. Review the warnings above" -ForegroundColor White
Write-Host "  2. Install Visual Studio or Build Tools if not already installed" -ForegroundColor White
Write-Host "  3. Run build.ps1 to attempt compilation" -ForegroundColor White
Write-Host ""

# Pause to see the output
if ($Host.Name -eq "ConsoleHost") {
    Write-Host "Press any key to exit..."
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
}
