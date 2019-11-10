:: prepare nmake environment for cmake and build project

setlocal EnableDelayedExpansion

:: project specifics
set BUILD_DIR="%BUILDS%\vulkan-sasha"
set PROJECT_DIR="%HOME%\Projects\Vulkan"

set VSCMD_START_DIR=%BUILD_DIR%
set CL=/MP
call "%VCVARSALL%\vcvarsall.bat" amd64
cmake "%PROJECT_DIR%" -G"NMake Makefiles" -DCMAKE_EXPORT_COMPILE_COMMANDS=1
IF EXIST "%BUILD_DIR%\compile_commands.json" (COPY /Y "%BUILD_DIR%\compile_commands.json" "%PROJECT_DIR%")
nmake BUILD=Release
pause;