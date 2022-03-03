"-- General
"
let mapleader=" "

set syntax=on
set encoding=UTF-8
set confirm
set showcmd
set visualbell
set tabstop=2     " 1 tab = 2 spaces
set shiftwidth=2  " text is indented 2 columns with re-indent operations
set softtabstop=2 " 1 tab = 2 spaces (insert mode)
set expandtab     " Replaces tab with spaces
set smarttab      " Uses shiftwidth instead of tabstop at start of lines
set smartindent
set hlsearch      " Highlight search results
set incsearch     " Show search results as I type
set nojoinspaces  " Only one space after .
set ignorecase    " Search case insensitive...
set smartcase     " ... but not it begins with upper case
set nowrap
set laststatus=2  " Always display the status line
set autoread      " Automatically read changed files
set autowrite     " Automatically :write before running commands
set showcmd       " Show me what I'm typing
set backspace=indent,eol,start
set nobackup
set nowritebackup
set noswapfile
set modelines=0   " Disable modelines as a security precaution
set nomodeline    " Disable modelines as a security precaution
set number
set relativenumber
set signcolumn=number
if has("persistent_undo")
  silent !mkdir ~/.config > /dev/null 2>&1
  silent !mkdir ~/.config/nvim > /dev/null 2>&1
  silent !mkdir ~/.config/nvim/undodir > /dev/null 2>&1
  set undodir=~/.config/nvim/undodir
  set undofile
endif
set wildignore+=**/coverage/*
set wildignore+=**/node_modules/*
set wildignore+=**/android/*
set wildignore+=**/ios/*
set wildignore+=**/.git/*
set splitbelow
set splitright
set hidden
set mouse=a
set textwidth=80 " Make it obvious where 80 characters is
set colorcolumn=80
highlight ColorColumn ctermbg=lightgrey guibg=lightgrey


"-- Plugins
"
call plug#begin('~/.config/nvim/plugged')
Plug 'christoomey/vim-tmux-navigator'
Plug 'lifepillar/vim-solarized8'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'preservim/nerdtree'
call plug#end()

lua require('qbantek')


"-- COLORS
"
set background=dark
set termguicolors
colorscheme solarized8
au TextYankPost * silent! lua vim.highlight.on_yank {on_visual=false}

"-- MOVEMENT
"
:inoremap jk <Esc> " Map jk
:inoremap kj <Esc> "    & kj to Esc

" Disable arrow movement, re-size splits instead.
nnoremap <Up>    :resize +2<CR>
nnoremap <Down>  :resize -2<CR>
nnoremap <Left>  :vertical resize +2<CR>
nnoremap <Right> :vertical resize -2<CR>

" disable tmux navigation when zoomed in
let g:tmux_navigator_disable_when_zoomed = 1

"-- SEARCHING
"
set tags=tags;
set tags+=gems.tags; " Support for gem ctags

" Ignore when expanding wildcards
set wildignore=*/node_modules/*,*/tmp/*,*/.idea/*,*/.git/*

" This unsets the "last search pattern" register by hitting return 
nnoremap <silent> <CR> :nohlsearch<CR><CR>

" Scroll the screen and do not move the cursor when jumping to next result
nnoremap n nzzzv
nnoremap N Nzzzv

" Map Ctrl-n to NERDTree
map <C-n> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1
let NERDTreeQuitOnOpen=1
let NERDTreeIgnore=['\.py[cd]$', '\~$', '\.swo$', '\.swp$', '^\.git$', '^\.hg$', '^\.svn$', '\.bzr$']
let NERDTreeStatusline="%{exists('b:NERDTree')?fnamemodify(b:NERDTree.root.path.str(), ':~'):''}"

"-- COMMIT MESSAGES
"
augroup gitcommit
  autocmd!
  autocmd Filetype gitcommit setlocal spell textwidth=72
augroup END
