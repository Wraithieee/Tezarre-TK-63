@echo off
echo.
echo   Tezarre TK-63 - Installer Launcher
echo   ====================================
echo.
echo   Unblocking and launching setup...
echo.

powershell -ExecutionPolicy Bypass -Command ^
  "$f = '%~dp0Tezarre-TK63-Setup.exe'; ^
   if (!(Test-Path $f)) { Write-Host 'ERROR: Tezarre-TK63-Setup.exe not found in this folder.' -ForegroundColor Red; pause; exit 1 }; ^
   Unblock-File -Path $f; ^
   Write-Host 'Launching installer...' -ForegroundColor Green; ^
   Start-Process $f"

if %errorlevel% neq 0 (
    echo.
    echo   ERROR: Could not launch installer.
    echo   Try right-clicking Tezarre-TK63-Setup.exe and selecting Run as Administrator.
    pause
)
