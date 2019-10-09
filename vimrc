set encoding=utf-8
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

" Ruby/Rails-related plugins
Plugin 'thoughtbot/vim-rspec'
Plugin 'tpope/vim-bundler'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-rails'
Plugin 'sodapopcan/vim-rubocop'

" Javascript-related plugins
Plugin 'elzr/vim-json'
Plugin 'jelera/vim-javascript-syntax'

" Other
Plugin 'jiangmiao/auto-pairs'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'tpope/vim-fugitive'
Plugin 'jgdavey/tslime.vim'
Plugin 'L9'
Plugin 'JamshedVesuna/vim-markdown-preview'
Plugin 'scrooloose/nerdtree'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'kien/ctrlp.vim'
Plugin 'wincent/command-t'
call vundle#end()

filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just 
"                     :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to 
"                     auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

syntax enable
filetype plugin indent on

syntax on
set hlsearch
set background=dark
set ic
set nowrap

set laststatus=2  " Always display the status line
set autowrite     " Automatically :write before running commands

set smarttab
set expandtab

" size of a hard tabstop
set tabstop=2

" size of an "indent"
set shiftwidth=2

" a combination of spaces and tabs are used to simulate tab stops at a width
" other than the (hard)tabstop
set softtabstop=2

" this tells vim-rspec to use Send_to_Tmux to run the selected specs.
let g:rspec_command = 'call Send_to_Tmux("rspec {spec}\n")'

" Leader
let mapleader = " "

" Commanf-T
map <Leader>e <Plug>(CommandT)

" vim-rspec mappings
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>

" vim-rubocop
nmap <Leader>ra :RuboCop -a<CR>

" Trigger configuration. Do not use <tab> if you use
" https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" show line numbers by default
set relativenumber
set number
set ruler

" Make it obvious where 80 characters is
set textwidth=80
set colorcolumn=+1
highlight ColorColumn ctermbg=0 guibg=lightgrey

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" This unsets the "last search pattern" register by hitting return 
:nnoremap <silent> <CR> :nohlsearch<CR><CR

" Map Ctrl-n to NERDTree
map <C-n> :NERDTreeToggle<CR>

" Can be typed even faster than jj, and if you are already in
"    normal mode, you (usually) don't accidentally move:
:inoremap jk <Esc>
:inoremap kj <Esc>

" Support for gem ctags
set tags=tags;
set tags+=gems.tags;

" Enable Elite mode, No ARRRROWWS!!!!
let g:elite_mode=1

" Disable arrow movement, resize splits instead.
if get(g:, 'elite_mode')
  nnoremap <Up>    :resize +2<CR>
  nnoremap <Down>  :resize -2<CR>
  nnoremap <Left>  :vertical resize +2<CR>
  nnoremap <Right> :vertical resize -2<CR>
endif

" Folding
set foldmethod=indent
set foldlevel=1
set foldclose=all

let javaScript_fold=1
let vim_markdown_preview_github=1
