set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#rc()

if filereadable(expand("~/.vimrc.bundles"))
    source ~/.vimrc.bundles
endif

let mapleader = ','

let g:airline_powerline_fonts = 1
set laststatus=2
