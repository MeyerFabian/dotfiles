echo off
set mode=%1
IF [%mode%] == [] set mode=Debug
for %%I in (.) do set CurrDirName=%%~nxI
set BUILDFOLDER="Clang-%CurrDirName%-%mode%"
set BUILD_DIR="%BUILDS%\%BUILDFOLDER%"

%BUILD_DIR%\PreonLab
