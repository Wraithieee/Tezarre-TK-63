@echo off
echo.
echo   Tezarre TK-63 - Installer Launcher
echo   ====================================
echo.

powershell -ExecutionPolicy Bypass -Command ^
  "$f = '%~dp0Tezarre-TK63-Setup.exe'; ^
   if (!(Test-Path $f)) { ^
     Write-Host 'ERROR: Tezarre-TK63-Setup.exe not found in this folder.' -ForegroundColor Red; ^
     pause; exit 1 ^
   }; ^
   $size = (Get-Item $f).Length; ^
   if ($size -lt 50000000) { ^
     Write-Host '================================================================' -ForegroundColor Yellow; ^
     Write-Host 'WARNING: The Tezarre-TK63-Setup.exe in this folder is an LFS pointer' -ForegroundColor Yellow; ^
     Write-Host 'file (' + [math]::Round($size/1KB, 1) + ' KB) instead of the full installer (106 MB).' -ForegroundColor Yellow; ^
     Write-Host 'This is why Windows says check with the software publisher.' -ForegroundColor Yellow; ^
     Write-Host 'Opening the real installer download in your browser now...' -ForegroundColor Green; ^
     Write-Host '================================================================' -ForegroundColor Yellow; ^
     Start-Process 'https://github.com/Wraithieee/Tezarre-TK-63/releases/download/v1.2.4/Tezarre-TK63-Setup.exe'; ^
     pause; exit 0 ^
   }; ^
   Write-Host 'Unblocking and launching setup...' -ForegroundColor Cyan; ^
   Unblock-File -Path $f; ^
   Write-Host 'Launching installer...' -ForegroundColor Green; ^
   Start-Process $f"

if %errorlevel% neq 0 (
    echo.
    echo   ERROR: Could not launch installer.
    echo   Try right-clicking Tezarre-TK63-Setup.exe and selecting Run as Administrator.
    pause
)

