set nocompatible

"+++ Basics

set clipboard+=unnamed,autoselect
set hidden
set viminfo+=n~/.vim/tmp/.viminfo
set directory=~/.vim/tmp
set backupdir=~/.vim/tmp
set dict=~/.vim/dict/general.dict
set number
set enc=utf-8
set fencs=utf-8,cp932

"+++ Indent
set autoindent
set smartindent
set cindent

set expandtab
set tabstop=2 shiftwidth=2 softtabstop=2

if has("autocmd")
  filetype plugin on
  filetype indent on

  autocmd FileType php setlocal ts=4 sw=4 sts=4 et
  autocmd FileType html setlocal ts=2 sw=2 sts=2 et
endif

"+++ Extra

" wb2g blog ignore keywords '-'
autocmd BufNewFile,BufRead ~/wb2g/blog/article/* set isk+=\=,\"

"+++ Search
nnoremap <Esc><Esc> :nohlsearch<CR><Esc>
