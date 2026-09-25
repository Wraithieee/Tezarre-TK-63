param()
Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$ScriptDir   = $PSScriptRoot
$RepoRoot    = Split-Path $ScriptDir -Parent
$IssFile     = Join-Path $ScriptDir "TezarreTK63.iss"
$IsccPaths   = @(
    "C:\Program Files (x86)\Inno Setup 6\ISCC.exe",
    "C:\Program Files\Inno Setup 6\ISCC.exe",
    "$env:LOCALAPPDATA\Programs\Inno Setup 6\ISCC.exe"
)
$InnoInstaller = Join-Path $env:TEMP "innosetup-installer.exe"

Write-Host ""
Write-Host "  +------------------------------------------------+" -ForegroundColor Cyan
Write-Host "  |  Tezarre TK-63 -- Installer Builder  v1.0     |" -ForegroundColor Cyan
Write-Host "  +------------------------------------------------+" -ForegroundColor Cyan
Write-Host ""

# --- Step 1: Locate or install Inno Setup ---
$IsccExe = $null
foreach ($p in $IsccPaths) {
    if (Test-Path $p) { $IsccExe = $p; break }
}

if (-not $IsccExe) {
    Write-Host "  [1/3] Inno Setup not found. Downloading..." -ForegroundColor Yellow

    $InnoUrl = "https://files.jrsoftware.org/is/6/innosetup-6.4.3.exe"
    try {
        Invoke-WebRequest -Uri $InnoUrl -OutFile $InnoInstaller -UseBasicParsing
        Write-Host "  [1/3] Installing Inno Setup silently..." -ForegroundColor Yellow
        Start-Process -FilePath $InnoInstaller -ArgumentList "/VERYSILENT /NORESTART /SUPPRESSMSGBOXES" -Wait
        Remove-Item $InnoInstaller -Force -ErrorAction SilentlyContinue
    }
    catch {
        Write-Host ""
        Write-Host "  ERROR: Could not download Inno Setup automatically." -ForegroundColor Red
        Write-Host "  Install it manually from: https://jrsoftware.org/isdl.php" -ForegroundColor Red
        Write-Host "  Then re-run this script." -ForegroundColor Red
        exit 1
    }

    foreach ($p in $IsccPaths) {
        if (Test-Path $p) { $IsccExe = $p; break }
    }

    if (-not $IsccExe) {
        Write-Host "  ERROR: Inno Setup installed but ISCC.exe not found." -ForegroundColor Red
        Write-Host "  Try running this script as Administrator." -ForegroundColor Red
        exit 1
    }

    Write-Host "  [1/3] Inno Setup ready: $IsccExe" -ForegroundColor Green
}
else {
    Write-Host "  [1/3] Inno Setup found: $IsccExe" -ForegroundColor Green
}

# --- Step 2: Validate required source files ---
Write-Host "  [2/3] Validating source files..." -ForegroundColor Yellow

$RequiredFiles = @(
    (Join-Path $RepoRoot "Tezarre-TK63.exe"),
    (Join-Path $RepoRoot "resources\app.asar"),
    (Join-Path $RepoRoot "resources\app.asar.unpacked")
)

$Missing = $false
foreach ($f in $RequiredFiles) {
    if (-not (Test-Path $f)) {
        Write-Host "  MISSING: $f" -ForegroundColor Red
        $Missing = $true
    }
}
if ($Missing) {
    Write-Host ""
    Write-Host "  ERROR: Required source files are missing. Check paths above." -ForegroundColor Red
    exit 1
}

Write-Host "  [2/3] All required files present." -ForegroundColor Green

# --- Step 3: Compile the installer ---
Write-Host "  [3/3] Compiling installer (this may take a minute)..." -ForegroundColor Yellow
Write-Host ""

Push-Location $ScriptDir
try {
    & $IsccExe $IssFile
    $ExitCode = $LASTEXITCODE
}
finally {
    Pop-Location
}

Write-Host ""
if ($ExitCode -eq 0) {
    $OutputExe = Join-Path $ScriptDir "Tezarre-TK63-Setup.exe"
    if (Test-Path $OutputExe) {
        $SizeMB = [math]::Round((Get-Item $OutputExe).Length / 1MB, 1)
        Write-Host "  [OK] Build succeeded!" -ForegroundColor Green
        Write-Host ""
        Write-Host "  Output : $OutputExe" -ForegroundColor Cyan
        Write-Host "  Size   : $SizeMB MB" -ForegroundColor Cyan
        Write-Host ""
        Write-Host "  Copy Tezarre-TK63-Setup.exe to any Windows PC and double-click to install." -ForegroundColor White
    }
    else {
        Write-Host "  [WARN] Compiler exited OK but setup exe not found at expected path." -ForegroundColor Yellow
        Write-Host "  Check the installer\ folder manually." -ForegroundColor Yellow
    }
}
else {
    Write-Host "  [FAIL] ISCC exited with code $ExitCode. Build failed." -ForegroundColor Red
    Write-Host "  Check the output above for details." -ForegroundColor Red
    exit $ExitCode
}
