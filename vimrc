" PJ's VIM configuration

set relativenumber
set nocompatible
set autowrite
set history=700
set ruler
set cmdheight=2
set noautochdir
au FocusLost * :wa

" Remap caps-lock
au VimEnter * !xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape'

" Normal regexes for searching
nnoremap / /\v
vnoremap / /\v

" Rebind <Leader> key
let mapleader=","

" Make copy-paste useable
set clipboard=unnamed

" Automatic reloading of .vimrc
autocmd! BufWritePost .vimrc source %

" Make search dynamic
set hlsearch
set incsearch

" Make search results highlight
set showmatch
set mat=2

" Clear search results
nnoremap <leader><space> :noh<cr>

" And distinguish the active match
nnoremap <silent> n   n:call HLNext(0.5)<cr>
nnoremap <silent> N   N:call HLNext(0.5)<cr>

function! HLNext (blinktime)
  highlight BlackOnYellow ctermfg=Black ctermbg=yellow
  let [bufnum, lnum, col, off] = getpos('.')
  let matchlen = strlen(matchstr(strpart(getline('.'),col-1),@/))
  let target_pat = '\c\%#'.@/
  let blinks = 3
  for n in range(1, blinks)
    let red = matchadd('BlackOnYellow', target_pat, 101)
    redraw
    exec 'sleep' . float2nr(a:blinktime / (2*blinks) * 1000) . 'm'
    call matchdelete(red)
    redraw
    exec 'sleep' . float2nr(a:blinktime / (2*blinks) * 1000) . 'm'
  endfor
endfunction

" Set colorscheme and syntax highlighting
syntax on
colorscheme molokai
set t_Co=256
let g:molokai_original = 1
let g:rehash256 = 1
set background=dark

set cpoptions+=$

" Auto indenting for all filetypes
set autoindent
set smartindent
set expandtab
set smarttab

" Set tabs to equal 4 spaces instead of real tabs
set shiftwidth=4
set tabstop=4
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

" Setup Pathogen
" mkdir -p ~/.vim/autoload ~/.vim/bundle
" curl -so ~/.vim/autoload/pathogen.vim https://raw.github.com/tpope/vim-pathogen/HEAD/autoload/pathogen.vim
" Now you can install any plugin into a .vim/bundle/plugin-name/ folder
" Load Pathogen
runtime! autoload/pathogen.vim
if exists("*pathogen#infect")
    call pathogen#infect()
endif

" Make sure filetype specific configurations are being loaded
filetype on
filetype plugin on
filetype indent on

"" fold settings
set foldmethod=syntax

"" Make folds persistent between editing sessions
autocmd BufWinLeave *.* mkview!
autocmd BufWinEnter *.* silent loadview

"" Easy navigation between windows
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

"" Easy navigation between tabs
map <Leader>T <esc>:tabprevious<CR>
map <Leader>t <esc>:tabnext<CR>

" Look for a tags-file from the current directory up
set tags=./tags;/

" Use <,>f/F to fold/unfold
nnoremap <Leader>f za
nnoremap <Leader>F zA

" Open todos
map <Leader>td <Plug>TaskList

" Easier moving of visual code blocks with better indentation
vnoremap < <gv
vnoremap > >gv

" NERDTree
noremap <Leader>n :NERDTreeToggle<CR>

" Mistypings...
:iabbrev teh the

" Keep line length to 80 columns max (just a warning)
highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%80v', 100) 

"" Filetype templates
" Python
let g:pymode_trim_whitespaces = 0
autocmd BufNewFile,BufWinEnter *.py set filetype=python
map <F7> :PymodeLint<CR>

" Python-mode
let g:pymode_rope = 0 " to use jedi-vim for autocompletion

" XML
let g:xml_syntax_folding=1
autocmd FileType xml setlocal foldmethod=syntax

" Haskell
let g:haddock_browser = "/usr/bin/firefox"

" gundo.vim
nnoremap <Leader>u :GundoToggle<CR>
let g:gundo_right = 1
let g:gundo_preview_bottome = 1

" Ack.vim
 let g:ackprg = 'ag --nogroup --nocolor --column'
