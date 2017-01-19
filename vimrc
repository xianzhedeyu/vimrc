set history=5000
set modeline

"enable filetype plugin
filetype on 
filetype plugin on
filetype plugin indent on     " required!
set completeopt=longest,menu

set list "显示制表符
set listchars=tab:>-,trail:-

"set autochdir "自动设置目录为正在编辑的文件所在的目录

"文件自动检测外部更改
set autoread
"鼠标一直可用
set mouse=a

let mapleader=','
let g:mapleader=','

map <leader>q :q<cr>
map <leader>u :undolist<cr>
"打开所在目录
map <leader>f :Ex<cr>
map <leader>cd :cd %:p:h<cr>
inoremap ;; <ESC>
nmap :X :x
nmap :W :w
nmap :Q :q
nmap :qa :quitall
nmap :QA :quitall

syntax on

set guifont=DejaVu\ Sans\ Mono\ 20

"highlight current
if has("gui_running")
    set cursorline
    hi cursorline guibg=#333333
    hi CursorColumn guibg=#333333
endif

"文件没有保存或只读时弹出确认
set confirm
"不需要备份
set nobackup
set noswapfile
"使用vim的键盘模式
set nocompatible
set magic

set showmatch
set showfulltag

set ruler
"显示状态栏（默认值为1，不显示)
set laststatus=2
"命令行补全
set wildmenu
set cmdheight=1

inoremap <C-a> <Home>
inoremap <C-e> <End>
inoremap <C-k> <Esc>wd$i
inoremap <C-d> <del>

"括号自动补全
inoremap ( ()<Esc>i
inoremap ) <c-r>=ClosePair(')')<CR>
inoremap { {}<Esc>i
inoremap } <c-r>=ClosePair('}')<CR>
inoremap [ []<ESC>i
inoremap ] <c-r>=ClosePair(']')<CR>
inoremap < <><ESC>i
inoremap > <c-r>=ClosePair('>')<CR>

function ClosePair(char)
    if getline('.')[col('.') - 1] == a:char
         return "\<Right>"
    else
         return a:char
    endif
endf

set encoding=utf8
set number
set relativenumber

set cursorline

set smartindent
set autoindent
set cindent
set wrap       

set tabstop=4 
set shiftwidth=4
set expandtab  
set smarttab
set lbr
set tw=800

"Enable folding
set nofen
set fdl=0

set backspace=indent,eol,start

set ignorecase
set incsearch
set hlsearch

noremap <silent> <expr> j (v:count == 0 ? 'gj':'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk':'k')

"Golang
autocmd BufRead,BufNewFile *.go set filetype=go

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle
Bundle 'gmarik/vundle'

Bundle 'scrooloose/nerdtree'
map <C-n> :NERDTreeToggle<CR> :NERDTreeMirror<CR>
" support for git flags
Bundle 'Xuyuanp/nerdtree-git-plugin'
let NERDTreeShowBookmarks=1
"have the nerdtree on every tab automatically
Bundle 'jistr/vim-nerdtree-tabs'
"NERDTree File highlighting
"have different highlighting for different file extensions
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
     exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
     exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

call NERDTreeHighlightFile('hrl', 'green', 'none', 'green', '#151515')
call NERDTreeHighlightFile('erl', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('ini', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', '#151515')
call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('coffee', 'Red', 'none', 'red', '#151515')
call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', '#151515')
call NERDTreeHighlightFile('php', 'Magenta', 'none', '#ff00ff', '#151515')

Bundle 'scrooloose/nerdcommenter'

"Syntax checking hacks for vim
Bundle 'scrooloose/syntastic'
let g:syntastic_always_populate_loc_list = 0
let g:syntastic_auto_loc_list = 0 
let g:syntastic_check_on_open = 0 
let g:syntastic_check_on_wq = 0

"perform all your vim insert mode completions with Tab
Bundle 'ervandew/supertab'

"interpret a file by function and cache file automatically
Bundle 'MarcWeber/vim-addon-mw-utils'
Bundle 'tomtom/tlib_vim'
"default snippets
"Bundle 'honza/vim-snippets'

"Bundle 'garbas/vim-snipmate'

"he plugin provides mappings to easily delete, change and add such
"surroundings in pairs.
"Bundle 'tpope/vim-surround'
Bundle 'jimenezrick/vimerl'

"Vim motions on speed
Bundle 'Lokaltog/vim-easymotion'

Bundle 'kien/ctrlp.vim'
let g:ctrlp_map = '<Leader>t'
nmap ; :CtrlPBuffer<CR>
Bundle 'godlygeek/tabular'
Bundle 'vim-scripts/taglist.vim'
let Tlist_Show_One_File=1 "只显示当前文件的taglist, 默认是显示多个
let Tlist_Exit_OnlyWindow=1 "如果taglist是最后一个窗口，则退出vim
let Tlist_Use_Right_Window=1 "在右侧窗口中显示taglist
let Tlist_GainFocus_On_ToggleOpen=0 "设置为1时，表示打开taglist时，光标保留在taglist窗口
let Tlist_Ctags_Cmd='/opt/local/bin/ctags' "设置ctags命令的位置
let Tlist_Sort_Type='name' "taglist默认按tag在文件中出现的顺序进行排序，设置为name，taglist将以tag名字进行排序
let Tlist_Auto_Open=1 "如果想在启动vim后自动打开taglist窗口，该参数设置为1
nnoremap <leader>tl :Tlist<CR> "设置关闭和打开taglist窗口的快捷键

Bundle 'Lokaltog/powerline'
let g:Powerline_symbols = 'fancy'
set encoding=utf-8
set t_Co=256
set fillchars+=stl:\ ,stlnc:\
set term=xterm-256color
set termencoding=utf-8

" map keys
map <Down> gj
map <Up> gk
map <leader>1 1gt  
map <leader>2 2gt  
map <leader>3 3gt  
map <leader>4 4gt  
map <leader>5 5gt  
map <leader>6 6gt  
map <leader>7 7gt  
map <leader>8 8gt  
map <leader>9 9gt

map <leader>w <C-w>w

let g:erlang_keywordprg = 'man'
set tags=/Users/zhaoxiaosen/work/wesync/tags,/Users/zhaoxiaosen/work/nginx-1.9.15/tags,/Users/zhaoxiaosen/work/redis-2.8.19/tags 

call vundle#end()
"source /Users/zhaoxiaosen/.vim/cscope_maps.vim
