# prepare nmake environment for cmake and build project
set VSCMD_START_DIR="D:\builds\snow-nmake"
call "D:\Software\VS 2017\VC\Auxiliary\Build\vcvarsall.bat" amd64
cmake "C:\Users\fabia\ProgramingEnv\Projects\snow" -G"NMake Makefiles"
nmake BUILD=Release
