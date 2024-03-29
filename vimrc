set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#rc()
" Plugins {{{
Bundle 'VundleVim/Vundle.vim'
Bundle 'vim-airline/vim-airline'
Bundle 'vim-airline/vim-airline-themes'
Bundle 'tpope/vim-fugitive'
Bundle 'scrooloose/nerdtree'
Bundle 'skreuzer/vim-prometheus'
Bundle 'mhinz/vim-signify'
Bundle 'godlygeek/tabular'
Bundle 'ntpeters/vim-better-whitespace'
Bundle 'ctrlpvim/ctrlp.vim'
Bundle 'tpope/vim-surround'
Bundle 'Keithbsmiley/tmux.vim'
Bundle 'Absolight/vim-bind'
Bundle 'rhysd/committia.vim'
Bundle 'kien/rainbow_parentheses.vim'
Bundle 'mustache/vim-mustache-handlebars'
Bundle 'morhetz/gruvbox'
Bundle 'Yggdroot/indentLine'
Bundle 'toyamarinyon/vim-swift'
Bundle 'Valloric/YouCompleteMe'
Bundle 'djoshea/vim-autoread'
Bundle 'w0rp/ale'
Bundle 'Xuyuanp/nerdtree-git-plugin'
" }}}
syntax on
let mapleader = ','

set encoding=utf8

set laststatus=2
set background=dark
colorscheme gruvbox

" Plugin Configuration {{{
" Airline {{{
let g:airline_powerline_fonts = 1
let g:airline_left_sep=' '
let g:airline_right_sep=' '
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#right_sep = ' '
let g:airline#extensions#tabline#right_alt_sep = '|'
" }}}
" Signify {{{
let g:signify_vcs_list = [ 'svn', 'git' ]
let g:signify_update_on_bufenter = 1
" }}}
" CtrlP {{{
let g:ctrlp_map = '<c-p>'
let g:ctrlp_max_height = 30
let g:ctrlp_working_path_mode = 0
let g:ctrlp_match_window_reversed = 0
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
" }}}
" Indent Line {{{
let g:indentLine_char = '┆'
let g:indentLine_color_term=239
nmap <leader>i :IndentLinesToggle<CR>
" }}}
" Rainbow Parentheses {{{
" Always On:
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces
" }}}
" Committia {{{
let g:committia_hooks = {}
function! g:committia_hooks.edit_open(info)
    setlocal spell
    " If no commit message, start with insert mode
    if a:info.vcs ==# 'git' && getline(1) ==# ''
        startinsert
    end

    " Scroll the diff window from insert mode
    " Map <C-n> and <C-p>
    imap <buffer><C-n> <Plug>(committia-scroll-diff-down-half)
    imap <buffer><C-p> <Plug>(committia-scroll-diff-up-half)
endfunction
" }}}
" NERDTree Configuration {{{
map <silent> <C-n> :NERDTreeToggle<CR>
" Open NERDTree on startup if no files were specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Close vim if the only window open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
" }}}
" }}}
" Key Mappings {{{
map  <up> <nop>
map  <down> <nop>
map  <left> <nop>
map  <right> <nop>
cmap w!! w !sudo tee > /dev/null %
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>
nnoremap Q <nop>
nnoremap ; :
" Resize Splits {{{
map <leader>> <C-w>10>
map <leader>< <C-w>10<
map <leader>= <C-w>5+
map <leader>- <C-w>5-
" }}}
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
" ,x brings up my .vimrc
" ,V reloads it -- making all changes active (have to save first)
map <leader>x :sp ~/.vimrc<CR><C-W>
map <silent><leader>V :source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>
" Preserve selection after indentation in visual mode
vmap > >gv
vmap < <gv
" }}}
" Interface {{{
set number
set showmatch              " Show me matching close braces
set ruler
set colorcolumn=81         " Make column 81 magenta
highlight clear SignColumn
highlight VertSplit    ctermbg=236
highlight ColorColumn  ctermbg=237
highlight LineNr       ctermbg=236 ctermfg=240
highlight CursorLineNr ctermbg=236 ctermfg=240
highlight CursorLine   ctermbg=236
highlight StatusLineNC ctermbg=238 ctermfg=0
highlight StatusLine   ctermbg=240 ctermfg=12
highlight IncSearch    ctermbg=3   ctermfg=1
highlight Search       ctermbg=1   ctermfg=3
highlight Visual       ctermbg=3   ctermfg=0
highlight Pmenu        ctermbg=240 ctermfg=12
highlight PmenuSel     ctermbg=3   ctermfg=1
highlight SpellBad     ctermbg=0   ctermfg=1
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
function! Set_SGML() " {{{
    call ShowSpecial()
    setlocal nonumber
    setlocal noexpandtab
    syn match sgmlSpecial "&[^;]*;"
    setlocal syntax=sgml
    setlocal ft=sgml
    setlocal shiftwidth=2
    setlocal textwidth=72
    setlocal tabstop=8
    highlight OverLength ctermbg=red ctermfg=white guibg=#592929
    match OverLength /\%71v.\+/
    return 0
endfunction
" }}}
function! ShowSpecial() " {{{
    setlocal list listchars=tab:>>,trail:*,eol:$
    hi nontext ctermfg=red
    return 0
endfunction
" }}}
" }}}
" Whitespace {{{
set nowrap                        " don't wrap lines
set tabstop=4                     " a tab is four spaces
set softtabstop=4                 " number of spaces in tab when editing
                                  " this value is the number of spaces that is inserted when you hit <TAB>
                                  " and also the number of spaces that are removed when you backspace.

set autoindent
set copyindent                    " copy the indentation from the previous line
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
" Wild Mode {{{
set wildmenu
set wildmode=list:longest,full
" Patterns to ignore when completing file or directory names
set wildignore+=.hg,.git,.svn " Version control
set wildignore+=*.aux,*.out,*.toc " LaTeX intermediate files
set wildignore+=*.zip,*.pdf,*.tar,*.gz " binary images
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg " images
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
set wildignore+=*.spl " compiled spelling word lists
set wildignore+=*.sw? " Vim swap files
set wildignore+=*.DS_Store " Directory attributes on OS X
" }}}

autocmd FileType make set noexpandtab

set lazyredraw " Don't redraw screen while executing macros
set ttyfast " Send more characters to the screen when redrawing
set ttymouse=xterm2 " Terminal type for which mouse codes are to be recognized
set mouse=i " Enable mouse use in insert mode


au BufNewFile,BufRead *.sgml,*.ent,*.xsl,*.xml call Set_SGML()

if has("gui_running")
    let s:uname = system("uname")
    if s:uname == "Darwin\n"
        Bundle 'ryanoasis/vim-devicons'
        set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Nerd\ Font\ Complete:h14
    endif
endif


" vim:foldmethod=marker:foldlevel=0
