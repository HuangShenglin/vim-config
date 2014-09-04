" .vimrc file
" Author: huang shenglin <hsl46346@163.com>


" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Don't use Ex mode, use Q for formatting
map Q gq

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  augroup END

else

  "set autoindent       " always set autoindenting on
  set cindent

endif " has("autocmd")


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" GLOBAL CONFIG


" PATHOGEN
" [:scriptnames] vim order, list all plugins
runtime bundle/vim-pathogen/autoload/pathogen.vim
let g:pathogen_disabled = [""]
call pathogen#infect()

" 不生成一个~备份文件
if has("vms")
  set nobackup      " do not keep a backup file, use versions instead
"else
"  set backup       " keep a backup file
endif

" keep 50 lines of command line history
set history=50

" show the cursor position all the time
set ruler

" display incomplete commands
set showcmd

"在输入要搜索的文字时，vim会实时匹配
set incsearch

syntax enable

filetype plugin on

"set number

"Set mapleader
let mapleader = ","

"Fast reloading of the .vimrc
map <silent> <leader>ss :source ~/.vimrc<cr>

"Fast editing of .vimrc
map <silent> <leader>ee :e ~/.vimrc<cr>

"When .vimrc is edited, reload it
"autocmd! bufwritepost .vimrc source ~/.vimrc

set completeopt=longest,menu

" color
colorscheme darkblue 

"启用了鼠标支持
"set mouse=a

"设定写入文档时的解码方式 为 UTF8
set fenc=utf-8

"启动缩进(C 语言的语法)
"set cindent

"依据上面的对起格式，智能的选择对起方式，对于类似C语言
"set smartindent

"设置匹配模式，类似当输入一个左括号时会匹配相应的那个右括号
set showmatch

"让一个tab等于4个空格
set tabstop=4

"设置缩进的空格数
set shiftwidth=4


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGINS CONFIG


"PHP函数联想功能
au FileType php call AddPHPFuncList()
function AddPHPFuncList()
    set dictionary-=~/.vim/php_funclist.txt dictionary+=~/.vim/php_funclist.txt
    set complete-=k complete+=k
endfunction

"autocmd FileType php runtime! autoload/phpcomplete.vim

" GOLANG
let g:go_disable_autoinstall = 0

" ctags
let g:tagbar_ctags_bin = "/home/shadow/opt/ctags/bin/ctags"

" gotags
let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }

" tarbar
nmap <F2> :TagbarToggle<CR>

" nerdtree
map <F3> :NERDTreeToggle<CR>

" powerline
set laststatus=2     " Always show the statusline
"set t_Co=256         " Explicitly tell Vim that the terminal support 256 colors
let g:Powerline_symbols = 'unicode'

" SingleCompile
nmap <F7> :SCCompile<cr>
nmap <F5> :SCCompileRun<cr>
