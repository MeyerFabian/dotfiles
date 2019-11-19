::export sys_env run as admin
setx HOME "%USERPROFILE%\ProgramingEnv" /m
setx BUILDS "D:\builds" /m
setx FZF "%HOME%\\.fzf\bin" /m
setx FZF_DEFAULT_COMMAND "rg --files" /m
setx XDG_CONFIG_HOME "%HOME%\.config"
setx PYTHONPATH "C:\Miniconda" /m
setx VCVARSALL /m "C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC"