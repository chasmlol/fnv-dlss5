@echo off
setlocal
title Fallout New Vegas - Vanilla Raster DLAA Host

set "GAME=%~dp0"

if not exist "%GAME%FalloutNV.exe" (
  echo ERROR: Put this file in the folder containing FalloutNV.exe.
  pause
  exit /b 1
)

if not exist "%GAME%.trex\reshade-layer\ReShade64.json" (
  echo ERROR: The project overlay is incomplete. Extract the release again.
  pause
  exit /b 1
)

if not exist "%GAME%.trex\nvngx_dlss.dll" (
  echo ERROR: .trex\nvngx_dlss.dll is missing.
  echo Copy the signed NVIDIA DLSS runtime into the .trex folder.
  pause
  exit /b 1
)

if not exist "%GAME%.trex\nvngx_dlssnr.dll" (
  echo ERROR: .trex\nvngx_dlssnr.dll is missing.
  echo Copy the signed NVIDIA Neural Rendering runtime into the .trex folder.
  pause
  exit /b 1
)

if not exist "%GAME%.trex\renodx-dlss5.addon64" (
  echo ERROR: .trex\renodx-dlss5.addon64 is missing.
  echo Obtain the addon from a trusted source and copy it into .trex.
  pause
  exit /b 1
)

set "VK_IMPLICIT_LAYER_PATH=%GAME%.trex\reshade-layer"
set "VK_ADD_IMPLICIT_LAYER_PATH="
set "DISABLE_VK_LAYER_reshade_1="
set "DXVK_FORCE_WINDOWED=1"

echo Starting Fallout: New Vegas...
echo ReShade: Home
echo RTX Remix: Alt+X
echo.

start "" /D "%GAME%" "%GAME%FalloutNV.exe"
exit /b %ERRORLEVEL%
