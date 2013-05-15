""""""""""""""""""""""""""""""""""
" Desc1984's vimrc
"
" Version
"   1.5
" Update Time
"   2013.05.11
"
" Wish you have a good vim tour!
""""""""""""""""""""""""""""""""""

"""""""""""""
"  General  "
"""""""""""""
" Show numbers
set nu
set nocompatible

" Show messagebox when need confirm
set confirm

filetype off
" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

"When .vimrc is edited, reload it
autocmd! bufwritepost .vimrc source ~/.vimrc 

" Turn backup off
set nobackup
set nowb
set noswapfile

" Set autopath
autocmd! BufWinEnter *    lcd %:p:h

"Set mapleader
let mapleader = ","

" System
if(has("win32") || has("win95") || has("win64") || has("win16"))
    let g:iswindows=1
else
    let g:iswindows=0
endif

if(iswindows == 0)
    "Fast reloading of the .vimrc
    map <silent> <leader>ss :source ~/.vimrc<cr>
    "Fast editing of .vimrc
    map <silent> <leader>ee :e ~/.vimrc<cr>
    "When .vimrc is edited, reload it
    autocmd! bufwritepost .vimrc source ~/.vimrc 
else
    map <silent> <leader>ss :source ~/_vimrc<cr>
    map <silent> <leader>ee :e ~/_vimrc<cr>
    autocmd! bufwritepost _vimrc source ~/_vimrc 
endif


"""""""""""""""""""""""
"  VIM user interface "
"""""""""""""""""""""""
" Turn on the WiLd menu
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc

"Always show current position
set ruler

" Height of the command bar
set cmdheight=2

"show matching bracket for 0.2 seconds
set matchtime=2

""""""""""""""""
"  Color&View  "
""""""""""""""""
" Enable syntax highlighting
syntax enable
syntax on

set cursorline

"close gui
"set go=

if g:iswindows==1
    "colorscheme darkblue
    colorscheme blackboard
    "set guifont=Courier_New:h12:w6
    set guifont=Consolas:h12:w6
    set guifontwide=����:h12
    "set guifontwide=NSimSun-18030,NSimSun
    set termencoding=GBK
else
    if has("gui_running")
        "color koehler
        colorscheme blackboard
    else
        "colorscheme koehler
        colorscheme blackboard
        let g:solarized_termcolors=256
    endif

    "set background=dark
    "colorscheme solarized
    set guifont=DejaVu\ Sans\ Mono\ 12
    set guifontwide=��Ȫ��ȿ�΢�׺�\ 12
    set termencoding=utf-8
endif

" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions+=e
    set t_Co=256
    set guitablabel=%M\ %t
endif

" Enable search highlight
set hlsearch

" Avoding Garbled
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,chinese,latin-1

if g:iswindows==1
    set fileencoding=chinese
    set termencoding=GBK
else
    set fileencoding=utf-8
endif
language messages zh_CN.UTF-8
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim
set langmenu=zh_CN.utf-8

""""""""""""""""""""""""""""""""""""""""""""""
"  Moving around, tabs, windows and buffers  "
""""""""""""""""""""""""""""""""""""""""""""""
" Treat long lines as break lines (useful when moving around in them)
map j gj
map k gk

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :nohl<cr>

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>tc :tabclose<cr>

" Configure backspace so it acts as it should act
"set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Default Indentation
set autoindent
set smartindent
set shiftwidth=4
set tabstop=4
set expandtab

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

""""""""""""""""
"  Status line " 
""""""""""""""""
" Always show the status line
set laststatus=2

" Format the status line
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ POS:\ %l,%v

"""""""""""""""""""
" Program & Debug "
"""""""""""""""""""
"QuickFix key map
autocmd FileType c,cpp  map <buffer> <leader><space> :w<cr>:make<cr>
nmap <leader>cn :cn<cr>
nmap <leader>cp :cp<cr>
nmap <leader>cw :cw 10<cr>

"Load project settings
if filereadable("project.vim")
    source project.vim
endif

""""""""""
" cscope "
""""""""""
set cscopequickfix=s-,c-,d-,i-,t-,e-

if has("cscope")
    set csprg=/usr/bin/cscope
    set csto=0
    set cst
    set nocsverb
    " add any database in current directory
    if filereadable("cscope.out")
        cs add cscope.out
        " else add database pointed to by environment
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif
    set csverb
endif

map <C-_> :cstag <C-R>=expand("<cword>")<CR><CR>
map g<C-]> :cs find 3 <C-R>=expand("<cword>")<CR><CR>
map g<C-\> :cs find 0 <C-R>=expand("<cword>")<CR><CR>

nmap <C-@>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-@>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-@>d :cs find d <C-R>=expand("<cword>")<CR><CR>

"""""""""""
" Plugins "
"""""""""""
source ~/.vim/bundles.vim

""""""""""""""
"  Functions "
""""""""""""""
" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    en
    return ''
endfunction

"""""""""""""""""""
" omni completion "
"""""""""""""""""""
"autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
"autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
"autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
"autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
"autocmd FileType c setlocal omnifunc=ccomplete#Complete
