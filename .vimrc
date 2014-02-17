" PJ's VIM configuration

set nu
set autowrite
set history=700
set ruler
set cmdheight=2

" Make search dynamic
set hlsearch
set incsearch

" Make search results highlight
set showmatch
set mat=2

" Set colorscheme and syntax highlighting
syntax on
colorscheme molokai
set t_Co=256
let g:molokai_original = 1
let g:rehash256 = 1
set background=dark
" toevoeging pj
noremap <C-p> :noh<CR>

" Auto indenting for all filetypes
set autoindent
set smartindent
set expandtab
set smarttab

" Set tabs to equal 2 spaces instead of real tabs
set shiftwidth=2
set tabstop=2
set lbr
set tw=500

" Make whitespace visible
exec "set listchars=tab:\uBB\uBB,trail:\uB7,nbsp:~"
set list

" Return to last edit position when opening files
function! ResCur()
    if line("'\"") <= line("$")
        normal! g`"
        return 1
    endif
endfunction

augroup resCur
    autocmd!
    autocmd BufWinEnter * call ResCur()
augroup END

"Always show the status line
set laststatus=2

"Load Pathogen
runtime! autoload/pathogen.vim
if exists("*pathogen#infect")
    call pathogen#infect()
endif

" Make sure filetype specific configurations are being loaded
filetype on
filetype plugin on
filetype indent on

" emmet-plugin configuration (zencoding)
let g:user_emmet_install_global = 0
let g:user_emmet_expandabbr_key = '<c-x>'
autocmd FileType html,css EmmetInstall

" fold settings
set nocompatible
set foldmethod=syntax

" Make folds persistent between editing sessions
autocmd BufWinLeave *.* mkview!
autocmd BufWinEnter *.* silent loadview

" Easy navigation between windows
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Filetype templates
" Python
autocmd BufNewfile *.py 0r ~/.vim/skeleton.py
autocmd BufNewFile,BufWinEnter *.py set filetype=python

" Look for a tags-file from the current directory up
set tags=./tags;/

" XML
let g:xml_syntax_folding=1
autocmd FileType xml setlocal foldmethod=syntax

" mappings
nnoremap <space> za
vnoremap <space> zf

" NERDTree mapping
" noremap <C-n> :NERDTreeToggle<CR>

" Eclim settings
set cot=menu
noremap <C-n> :ProjectTreeToggle<CR>
