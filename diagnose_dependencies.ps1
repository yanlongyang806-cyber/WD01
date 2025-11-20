# 诊断依赖问题
# 检查项目所需的所有依赖是否可用

Write-Host "=== 依赖诊断工具 ===" -ForegroundColor Cyan
Write-Host ""

$basePath = "I:\wd1"
$nightPath = "$basePath\Night"

# 检查基础路径
Write-Host "检查基础路径..." -ForegroundColor Yellow
if (-not (Test-Path $basePath)) {
    Write-Host "ERROR: 基础路径不存在: $basePath" -ForegroundColor Red
    exit 1
}
Write-Host "OK: 基础路径存在: $basePath" -ForegroundColor Green

if (-not (Test-Path $nightPath)) {
    Write-Host "ERROR: Night 目录不存在: $nightPath" -ForegroundColor Red
    exit 1
}
Write-Host "OK: Night 目录存在: $nightPath" -ForegroundColor Green
Write-Host ""

# 检查依赖
Write-Host "=== 检查依赖 ===" -ForegroundColor Cyan
Write-Host ""

$deps = @{
    "CrossRoads" = @(
        "$basePath\Cryptic\CrossRoads",
        "$basePath\CrossRoads",
        "$nightPath\..\Cryptic\CrossRoads",
        "$nightPath\..\CrossRoads"
    )
    "Core" = @(
        "$basePath\Cryptic\Core",
        "$basePath\core",
        "$nightPath\..\Cryptic\Core",
        "$nightPath\..\core"
    )
    "libs" = @(
        "$basePath\libs",
        "$nightPath\..\libs"
    )
    "PropertySheets" = @(
        "$basePath\PropertySheets",
        "$nightPath\..\PropertySheets"
    )
    "utilities" = @(
        "$basePath\utilities",
        "$nightPath\..\utilities"
    )
}

$foundDeps = @{}
$missingDeps = @()

foreach ($depName in $deps.Keys) {
    $found = $false
    foreach ($path in $deps[$depName]) {
        if (Test-Path $path) {
            Write-Host "OK: $depName 找到: $path" -ForegroundColor Green
            $foundDeps[$depName] = $path
            $found = $true
            break
        }
    }
    if (-not $found) {
        Write-Host "ERROR: $depName 未找到" -ForegroundColor Red
        $missingDeps += $depName
    }
}

Write-Host ""
Write-Host "=== 检查 structparser.exe ===" -ForegroundColor Cyan
Write-Host ""

$structparserPaths = @(
    "$basePath\utilities\bin\structparser.exe",
    "$nightPath\..\utilities\bin\structparser.exe"
)

$foundStructparser = $false
foreach ($path in $structparserPaths) {
    if (Test-Path $path) {
        Write-Host "OK: structparser.exe 找到: $path" -ForegroundColor Green
        $foundStructparser = $true
        break
    }
}

if (-not $foundStructparser) {
    Write-Host "ERROR: structparser.exe 未找到" -ForegroundColor Red
    Write-Host "   搜索其他位置..." -ForegroundColor Yellow
    $searchResult = Get-ChildItem $basePath -Recurse -Filter "structparser.exe" -ErrorAction SilentlyContinue | Select-Object -First 1
    if ($searchResult) {
        Write-Host "   WARNING: 在其他位置找到: $($searchResult.FullName)" -ForegroundColor Yellow
    }
}

Write-Host ""
Write-Host "=== 依赖摘要 ===" -ForegroundColor Cyan
Write-Host ""

$requiredDeps = @("CrossRoads", "Core")
$hasRequired = $true

foreach ($reqDep in $requiredDeps) {
    if ($foundDeps.ContainsKey($reqDep)) {
        Write-Host "OK: $reqDep (必需)" -ForegroundColor Green
    } else {
        Write-Host "ERROR: $reqDep (必需) - 缺失!" -ForegroundColor Red
        $hasRequired = $false
    }
}

foreach ($depName in $deps.Keys) {
    if ($depName -notin $requiredDeps) {
        if ($foundDeps.ContainsKey($depName)) {
            Write-Host "OK: $depName (可选)" -ForegroundColor Green
        } else {
            Write-Host "WARNING: $depName (可选) - 缺失" -ForegroundColor Yellow
        }
    }
}

Write-Host ""
Write-Host "=== 建议 ===" -ForegroundColor Cyan
Write-Host ""

if (-not $hasRequired) {
    Write-Host "ERROR: 缺少必需的依赖!" -ForegroundColor Red
    Write-Host ""
    Write-Host "解决方案:" -ForegroundColor Yellow
    Write-Host "1. 确保依赖存在于以下位置之一:" -ForegroundColor White
    Write-Host "   - I:\wd1\Cryptic\CrossRoads" -ForegroundColor Gray
    Write-Host "   - I:\wd1\Cryptic\Core" -ForegroundColor Gray
    Write-Host ""
    Write-Host "2. 或者运行 setup_dependencies.ps1 创建符号链接" -ForegroundColor White
    Write-Host ""
    Write-Host "3. 如果要在 GitHub 上编译，需要将依赖添加到仓库:" -ForegroundColor White
    Write-Host "   git add Cryptic/" -ForegroundColor Gray
    Write-Host "   git commit -m 'Add dependencies'" -ForegroundColor Gray
    Write-Host "   git push" -ForegroundColor Gray
} else {
    Write-Host "OK: 必需的依赖都已找到!" -ForegroundColor Green
    Write-Host ""
    Write-Host "如果 GitHub 编译仍然失败，可能是因为:" -ForegroundColor Yellow
    Write-Host "1. 依赖没有提交到 GitHub 仓库" -ForegroundColor White
    Write-Host "2. 需要将依赖添加到仓库根目录" -ForegroundColor White
    Write-Host ""
    Write-Host "查看 FIX_BUILD_ISSUES.md 了解详细解决方案" -ForegroundColor Cyan
}

Write-Host ""
Write-Host "=== 检查项目文件中的依赖路径 ===" -ForegroundColor Cyan
Write-Host ""

$vcxprojPath = "$nightPath\GameServer\NNOGameServer.vcxproj"
if (Test-Path $vcxprojPath) {
    Write-Host "检查项目文件: $vcxprojPath" -ForegroundColor Yellow
    $content = Get-Content $vcxprojPath -Raw
    
    # 查找包含路径
    $includePaths = [regex]::Matches($content, 'AdditionalIncludeDirectories[^>]*>([^<]+)</')
    if ($includePaths) {
        Write-Host "`n项目文件中的包含路径:" -ForegroundColor Yellow
        foreach ($match in $includePaths) {
            $paths = $match.Groups[1].Value -split ';'
            foreach ($path in $paths) {
                $cleanPath = $path.Trim()
                if ($cleanPath -match '\.\.\\\.\.') {
                    Write-Host "  $cleanPath" -ForegroundColor Gray
                }
            }
        }
    }
} else {
    Write-Host "WARNING: 项目文件未找到: $vcxprojPath" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "诊断完成!" -ForegroundColor Green
