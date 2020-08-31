echo off
set mode=%1
IF [%mode%] == [] set mode=Debug
setlocal EnableDelayedExpansion

for %%I in (.) do set CurrDirName=%%~nxI

set PROJECT_DIR="%cd%"
set BUILDFOLDER="Clang-%CurrDirName%-%mode%"
set BUILD_DIR="%BUILDS%\%BUILDFOLDER%"

cd /d %BUILDS%
mkdir "%BUILDFOLDER%"
cd %BUILDFOLDER%

cmake "%PROJECT_DIR%" -G"Ninja" -DCMAKE_BUILD_TYPE=%mode% -DPREON_QT_PATH="C:\Qt\5.15.0\msvc2019_64" -DCMAKE_EXPORT_COMPILE_COMMANDS=1 -DCMAKE_CXX_COMPILER=clang++.exe -DCMAKE_C_COMPILER=clang.exe
IF EXIST "%BUILD_DIR%\compile_commands.json" (COPY /Y "%BUILD_DIR%\compile_commands.json" "%PROJECT_DIR%")
ninja
pause;
