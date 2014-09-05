set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#rc()
" Plugins {{{
Bundle 'gmarik/Vundle.vim'
Bundle 'bling/vim-airline'
Bundle 'skreuzer/vim-colors-solarized'
Bundle 'tpope/vim-fugitive'
Bundle 'scrooloose/nerdtree'
Bundle 'skreuzer/nagios-syntax'
Bundle 'mhinz/vim-signify'
Bundle 'godlygeek/tabular'
Bundle 'ntpeters/vim-better-whitespace'
Bundle 'kien/ctrlp.vim'
Bundle 'neilhwatson/vim_cf3'
" }}}
syntax on
let mapleader = ','

set laststatus=2
set background=dark
colorscheme solarized

" Plugin Configuration {{{
let g:airline_powerline_fonts = 1
let g:signify_vcs_list = [ 'svn', 'git' ]
let g:signify_update_on_bufenter = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:EnableCFE3KeywordAbbreviations = 1
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
" ,x brings up my .vimrc
" ,V reloads it -- making all changes active (have to save first)
map <leader>x :sp ~/.vimrc<CR><C-W>
map <silent><leader>V :source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>
" }}}
" Interface {{{
set number
set showmatch              " Show me matching close braces
set ruler
set cursorline
set colorcolumn=81	   " Make column 81 magenta
highlight ColorColumn ctermbg=magenta
" }}}
" Functions {{{
function! NeatFoldText() " {{{
  let line = ' ' . substitute(getline(v:foldstart), '^\s*"\?\s*\|\s*"\?\s*{{' . '{\d*\s*', '', 'g') . ' '
  let lines_count = v:foldend - v:foldstart + 1
  let lines_count_text = '| ' . printf("%10s", lines_count . ' lines') . ' |'
  let foldchar = matchstr(&fillchars, 'fold:\zs.')
  let foldtextstart = strpart('+' . repeat(foldchar, v:foldlevel*2) . line, 0, (winwidth(0)*2)/3)
  let foldtextend = lines_count_text . repeat(foldchar, 8)
  let foldtextlength = strlen(substitute(foldtextstart . foldtextend, '.', 'x', 'g')) + &foldcolumn
  return foldtextstart . repeat(foldchar, winwidth(0)-foldtextlength) . foldtextend
endfunction
set foldtext=NeatFoldText()
" }}}
" }}}
" Whitespace {{{
set nowrap                        " don't wrap lines
set tabstop=4                     " a tab is four spaces
set softtabstop=4                 " number of spaces in tab when editing
                                  " this value is the number of spaces that is inserted when you hit <TAB>
                                  " and also the number of spaces that are removed when you backspace.

set shiftwidth=4                  " an autoindent (with <<) is four spaces
set expandtab                     " use spaces, not tabs
set backspace=indent,eol,start    " backspace through everything in insert mode
" List chars
set listchars=""                  " Reset the listchars
set listchars=tab:\|\             " a tab should display as |
set listchars+=trail:_            " show trailing spaces as _
set listchars+=extends:>          " The character to show in the last column when wrap is
                                  " off and the line continues beyond the right of the screen
set listchars+=precedes:<         " The character to show in the last column when wrap is
                                  " off and the line continues beyond the right of the screen
set list                          " Show invisible characters
" }}}

autocmd FileType make set noexpandtab
autocmd BufRead,BufNewFile *.cf normal zR

" vim:foldmethod=marker:foldlevel=0
