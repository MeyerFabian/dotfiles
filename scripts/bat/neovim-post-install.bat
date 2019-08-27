::install python 2.7
::install neovim
::install ycm
::install llvm

::register python in neovim
pip install neovim

::execute cmake
cd %HOME%\vimfiles\plugged\YouCompleteMe\third_party\ycmd\cpp
cmake -G"Visual Studio 15 2017" -DPATH_TO_LLVM_ROOT=D:\Software\llvm

::for rust support do (or update)
SET RUSTUP_HOME=%HOME%\vimfiles\plugged\YouCompleteMe\third_party\ycmd\third_party\rls
rustup toolchain install nightly
rustup default nightly
rustup component add rls rust-analysis rust-src

cd %HOME%\vimfiles\plugged\YouCompleteMe\third_party\ycmd\third_party\rls

for /d %i in ("*") do if /i not "%~nxi"=="toolchains" rd /s /q "%i"
for /d %i in ("toolchains\nightly-x86_64-pc-windows-msvc\*.*") do move %i %~pi..\..
rd /s /q toolchains
del /s /q settings.toml

::dokuwikixmlrpc archive download
pip install https://github.com/kynan/dokuwikixmlrpc/archive/master.zip