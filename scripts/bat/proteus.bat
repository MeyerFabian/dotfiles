:: prepare nmake environment for cmake and build project

setlocal EnableDelayedExpansion

:: project specifics
set BUILD_DIR="%BUILDS%\proteus"
set PROJECT_DIR="%HOME%\Projects\proteus"

cmake "%PROJECT_DIR%" -G"Visual Studio 14 2015 Win64" -DCMAKE_EXPORT_COMPILE_COMMANDS=1
