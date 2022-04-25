" Leader key -> " "
" In general, it's a good idea to set this early in your config, because 
" otherwise if you have any mappings you set BEFORE doing this, they will be 
" set to the OLD leader.
let mapleader=" "

set nocompatible
set syntax=on
set confirm
set showcmd
set visualbell
set tabstop=2     " 1 tab = 2 spaces
set shiftwidth=2  " text is indented 2 columns with re-indent operations
set softtabstop=2 " 1 tab = 2 spaces (insert mode)
set expandtab     " Replaces tab with spaces
set smartindent
set hlsearch      " Highlight search results
set nojoinspaces  " Only one space after .
set ignorecase    " Search case insensitive...
set smartcase     " ... but not it begins with upper case
set nowrap
set autowrite     " Automatically :write before running commands
set showcmd       " Show me what I'm typing
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
set wildignore+=**/.git/*
set wildignore+=**/coverage/*
set wildignore+=**/node_modules/*
set wildignore+=**/android/*
set wildignore+=**/ios/*
set wildignore+=**/tmp/*
set tags=tags
set tags+=gems.tags " Support for gem ctags
set splitbelow
set splitright
set hidden
set mouse=a
set textwidth=80 " Make it obvious where 80 characters is
set colorcolumn=80
set termguicolors
highlight ColorColumn ctermbg=lightgrey guibg=lightgrey

" use fzf in vim
set rtp+=/opt/homebrew/opt/fzf
