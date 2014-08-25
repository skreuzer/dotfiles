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

set background=dark
colorscheme solarized

" Disable Arrow Keys {{{
map  <up> <nop>
map  <down> <nop>
map  <left> <nop>
map  <right> <nop>
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>
" }}}

" vim:foldmethod=marker:foldlevel=0
