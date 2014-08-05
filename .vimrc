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
NeoBundle 'Shougo/vimfiler.vim'
NeoBundle 'tpope/vim-surround.git'
NeoBundle 'The-NERD-Commenter' " 2.0.0 A plugin that allows for easy commenting of code for many filetypes.
NeoBundle 'YankRing.vim' " 1.4   Maintains a history of previous yanks, changes and deletes
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'violetyk/neocomplete-php.vim'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'karakaram/vim-quickrun-phpunit'

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
set fileformat=unix

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

"+++ VimFiler
"autocmd VimEnter * VimFiler -split -simple -winwidth=30 -no-quit
let g:vimfiler_as_default_explorer=1
nnoremap <silent> <Leader>fi :<C-u>VimFiler -simple<CR>
nnoremap <silent> <Leader>fs :<C-u>VimFiler -split -simple -winwidth=30 -no-quit<CR>
nnoremap <silent> <Leader>fb :<C-u>VimFilerBufferDir -split -simple -winwidth=30 -no-quit<CR>

"+++ neocomplete
let g:neocomplete#enable_at_startup = 1

"+++ neocomplete-php
let g:neocomplete_php_locale = 'ja'

"+++ neosnippet
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)

imap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

"+++ NEADCommenter
let g:NERDSpaceDelims = 1
nmap ,, <Plug>NERDCommenterToggle
vmap ,, <Plug>NERDCommenterToggle

"+++ Window Handling Keymaps
nnoremap s <Nop>
nnoremap sv :<C-u>vs<Cr>
nnoremap ss :<C-u>sp<Cr>
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sh <C-w>h
nnoremap sJ <C-w>J
nnoremap sK <C-w>K
nnoremap sL <C-w>L
nnoremap sH <C-w>H
nnoremap sr <C-w>r
nnoremap sO <C-w>=
nnoremap st :<C-u>tabnew<Cr>
nnoremap sn gt
nnoremap sp gT
nnoremap sq :<C-u>q<Cr>
nnoremap sQ :<C-u>bd<Cr>
nnoremap sw :<C-u>w<Cr>
nnoremap sW :<C-u>wq<Cr>
nnoremap sT :<C-u>Unite tab<Cr>
nnoremap sb :<C-u>Unite buffer_tab<Cr>
nnoremap sB :<C-u>Unite buffer<Cr>
nnoremap sF :<C-u>Unite file<Cr>

"+++ Unite
noremap :uff :<C-u>UniteWithBufferDir file file/new -buffer-name=file<Cr>

"+++ Edit Keymap
nnoremap Y y$

"+++ CommandLine Mode
cnoremap %% <C-R>=expand('%:p:h').'/'<Cr>

"+++ Key Mapping for Anyone else...
nnoremap sd <ESC>i<C-r>=strftime("%Y/%m%d %H:%M:%S ")<Cr>
noremap! <silent> <C-j> <Esc>
nnoremap ; :

"+++ Quickrun
augroup QuickRunPHPUnit
	autocmd!
	autocmd BufWinEnter,BufNewFile *Test.php set filetype=php.phpunit
augroup END

let g:quickrun_config = {}
let g:quickrun_config['_'] = {}
let g:quickrun_config['_']['runnner'] = 'vimproc'
let g:quickrun_config['_']['runnner/vimproc/updatetime'] = 100
let g:quickrun_config['php.phpunit'] = {}
let g:quickrun_config['php.phpunit']['outputter'] = 'phpunit'
let g:quickrun_config['php.phpunit']['outputter/phpunit/height'] = 3
let g:quickrun_config['php.phpunit']['outputter/phpunit/running_mark'] = 'running....'
let g:quickrun_config['php.phpunit']['command'] = 'phpunit'
let g:quickrun_config['php.phpunit']['cmdopt'] = ''
let g:quickrun_config['php.phpunit']['exec'] = '%c %o %s'
"------------------------------------------------------------------
"- quickrun buffer outputter def
"------------------------------------------------------------------
" let g:quickrun_config['php.phpunit']['outputter'] = 'buffer'
" let g:quickrun_config['php.phpunit']['outputter/buffer/split'] = 'vertical 50'
" let g:quickrun_config['php.phpunit']['outputter/buffer/split'] = 'botright 17'
" let g:quickrun_config['php.phpunit']['outputter/error/error'] = 'quickfix'
" let g:quickrun_config['php.phpunit']['outputter/error/success'] = 'buffer'
" let g:quickrun_config['php.phpunit']['outputter'] = 'error'
"------------------------------------------------------------------

"+++ Loading local environment file
if filereadable(expand('~/.vimrc.local'))
  source ~/.vimrc.local
endif
