"日本語対応ファイル
if filereadable(expand('~/.vimrc.encode'))
  source ~/.vimrc.encode
endif

"vim互換モードをOFF
set nocompatible

"beep off
set visualbell t_vb=

"clipbord<=>yank/past
set clipboard+=autoselect
set clipboard+=unnamed

"backup
set backupdir=$HOME/vimbackup
set directory=$HOME/vimbackup

"search
set hlsearch
set incsearch
set ignorecase
set smartcase

"edit
set autoindent
set showmatch
set wildmenu
set backspace=indent,eol,start
set history=100
set hidden

"tab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set smarttab
set expandtab

"browse
set browsedir=buffer

"表示
set notitle
set showcmd
set showmode
syntax on
highlight Statement ctermfg=Magenta
highlight LineNr ctermfg=DarkBlue
highlight Search ctermfg=0
set laststatus=2

"options
set nf="" "１０進数に固定

"ステータス行表示形式
set statusline=%F%m%r%h%w%=%{(&fenc!=''?&fenc:&enc)}.%{&ff},%Y\ %l/%L(%p%%)
"set statusline=%F%m%r%h%w\%=%{&ff},%Y\ %l/%L(%p%%)

"ESCキー連打でハイライトを消す
nmap <Esc><Esc> :nohlsearch<CR><Esc>

"add filetype of skill++ (*.ils)
au BufRead,BufNewFile *.ils	set filetype=skill
au BufRead,BufNewFile *.cdsinit	set filetype=skill
au filetype skill set lisp
au filetype skill set dictionary=/home/watanab2/.vim/dict/skill.dict

"add filetype of calibre (*.tvf)
au BufRead,BufNewFile *.tvf	set filetype=tcl

"cd.vim
au BufEnter * execute ":cd " .expand("%:p:h")

" for python
autocmd FileType python set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
autocmd FileType python set expandtab tabstop=4 shiftwidth=4 softtabstop=4
" Execute python script C-P
function! s:ExecPy()
  exe "!" . &ft . " %"
:endfunction
command! Exec call <SID>ExecPy()
autocmd FileType python map <silent> <C-P> :call <SID>ExecPy()<CR>

" for sh
autocmd FileType sh map <silent> <C-P> :call <SID>ExecPy()<CR>
