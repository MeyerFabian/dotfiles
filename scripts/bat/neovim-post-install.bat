::install python 2.7
::install neovim
::install ycm
::install llvm

::register python in neovim
pip install neovim

::execute cmake
cd %HOME%\vimfiles\plugged\YouCompleteMe\third_party\ycmd\cpp
cmake -G"Visual Studio 15 2017" -DPATH_TO_LLVM_ROOT=D:\Software\llvm

::dokuwikixmlrpc archive download
pip install https://github.com/kynan/dokuwikixmlrpc/archive/master.zip