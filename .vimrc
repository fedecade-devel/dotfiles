set nocompatible

"+++ NeoBundle
filetype plugin indent off

if has('vim_starting')
  set runtimepath+=~/dotfiles/.vim/bundle/neobundle.vim/
  call neobundle#rc(expand('~/dotfiles/.vim/bundle/'))
endif

call neobundle#begin(expand('~/dotfiles/.vim/bundle/'))

NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimproc.vim'
NeoBundle 'tpope/vim-surround.git'
NeoBundle 'The-NERD-Commenter' " 2.0.0 A plugin that allows for easy commenting of code for many filetypes.
NeoBundle 'YankRing.vim' " 1.4   Maintains a history of previous yanks, changes and deletes
NeoBundle 'neocomplcache' " 2.36  Ultimate auto completion system for Vim

call neobundle#end()

filetype plugin indent on

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
