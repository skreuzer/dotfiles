set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#rc()

if filereadable(expand("~/.vimrc.bundles"))
    source ~/.vimrc.bundles
endif

syntax on
let mapleader = ','

set laststatus=2

set background=dark
colorscheme solarized

" Plugin Configuration {{{
let g:airline_powerline_fonts = 1
let g:signify_vcs_list = [ 'svn', 'git' ]
let g:signify_update_on_bufenter = 1
" }}}
" Arrow Keys {{{
map  <up> <nop>
map  <down> <nop>
map  <left> <nop>
map  <right> <nop>
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>
" }}}
" Searching {{{
set hlsearch                      " highlight matches
set incsearch                     " incremental searching
set ignorecase                    " searches are case insensitive...
set smartcase                     " ... unless they contain at least one capital letter
" turn off search highlight
nnoremap <leader><space> :nohlsearch<CR>
" }}}
" Keyboard Shortcuts {{{
nnoremap <leader>d :NERDTreeToggle<CR>
" }}}

" vim:foldmethod=marker:foldlevel=0
