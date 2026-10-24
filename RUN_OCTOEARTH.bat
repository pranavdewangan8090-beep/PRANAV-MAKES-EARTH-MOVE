@echo off
REM ==========================================================================
REM  OCTO-EARTH prototype launcher (Windows). Double-click to run.
REM  1. finds Python 3.10-3.13   2. creates .venv next to this file (no admin)
REM  3. installs missing packages from requirements.txt (internet needed once)
REM  4. runs octoearth_rl.py: physics checks -> viewer in browser -> PPO training
REM  Extra arguments are passed through, e.g.  RUN_OCTOEARTH.bat --smoke
REM ==========================================================================
setlocal
cd /d "%~dp0"
title OCTO-EARTH prototype

set "PYEXE="
where py >nul 2>nul && (
  for %%V in (3.13 3.12 3.11 3.10) do (
    if not defined PYEXE ( py -%%V -c "import sys" >nul 2>nul && set "PYEXE=py -%%V" )
  )
)
if not defined PYEXE (
  where python >nul 2>nul && (
    python -c "import sys; sys.exit(0 if (3,10)<=sys.version_info[:2]<=(3,13) else 1)" >nul 2>nul && set "PYEXE=python"
  )
)
if not defined PYEXE (
  echo.
  echo [OCTO-EARTH] Python 3.10 - 3.13 ^(64-bit^) was not found.
  echo Install it from https://www.python.org/downloads/ ^(tick "Add python.exe to PATH"^) and run this file again.
  pause
  exit /b 1
)
echo [OCTO-EARTH] using %PYEXE%

if not exist ".venv\Scripts\python.exe" (
  echo [OCTO-EARTH] creating virtual environment .venv ...
  %PYEXE% -m venv .venv
  if errorlevel 1 ( echo [OCTO-EARTH] could not create .venv & pause & exit /b 1 )
)
set "VPY=.venv\Scripts\python.exe"

"%VPY%" -c "import numpy, numba, gymnasium, stable_baselines3, torch" >nul 2>nul
if errorlevel 1 (
  echo [OCTO-EARTH] installing / repairing packages ^(first run downloads ~300 MB, needs internet^) ...
  "%VPY%" -m pip install --upgrade pip
  "%VPY%" -m pip install -r requirements.txt
  if errorlevel 1 ( echo [OCTO-EARTH] package installation failed - check the internet connection. & pause & exit /b 1 )
  "%VPY%" -c "import numpy, numba, gymnasium, stable_baselines3, torch" || ( echo [OCTO-EARTH] packages installed but cannot be imported. & pause & exit /b 1 )
)

echo [OCTO-EARTH] starting ... the browser opens automatically. Close this window or press Ctrl+C to stop.
"%VPY%" octoearth_rl.py %*
set "RC=%errorlevel%"
if not "%RC%"=="0" (
  echo.
  echo [OCTO-EARTH] exited with code %RC%. See the messages above.
  pause
)
endlocal
