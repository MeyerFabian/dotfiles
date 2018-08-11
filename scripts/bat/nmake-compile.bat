:: prepare nmake environment for cmake and build project
set VSCMD_START_DIR="%BUILDS%\snow-nmake"
call "%VCVARSALL%\vcvarsall.bat" amd64
cmake "%HOME%\Projects\snow" -G"NMake Makefiles"
nmake BUILD=Release
