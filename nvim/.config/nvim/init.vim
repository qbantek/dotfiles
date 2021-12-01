" --- General

set autoread                    " Automatically read changed files
set autowrite                   " Automatically write before running commands
set backspace=indent,eol,start  " more powerfule backspacing
set colorcolumn=+1              " highlight column after 'textwidth'
set encoding=UTF-8
set expandtab                   " Replaces tab with spaces
set hlsearch                    " Highlight search results
set ignorecase                  " Search is case insensitive
set incsearch                   " Show search results as I type
set laststatus=2                " Always display status line
set modelines=0                 " Disable modelines, security precaution
set mouse=a
set number
set numberwidth=1
set nobackup
set nojoinspaces                " Only one space after .
set nomodeline                  " Disable modelines, security precaution
set noswapfile
set nowrap
set nowritebackup
set relativenumber
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END
set ruler
set signcolumn=no
set showcmd                     " Show me what I am typing
set shiftwidth=2                " text is indented 2 columns w/re-indent operation
set smartcase                   " Case sensitive search if it begins with upper case
set smartindent
set smarttab                    " uses shiftwidth instead of tabstop at start of lines
set softtabstop=2               " 1 tab = 2 spaces, insert mode
set splitbelow
set splitright
set tabstop=2                   " 1 tab = 2 spaces
set tags=tags;
set tags+=gems.tags;
set termguicolors
set textwidth=80                " Make it obvious where 80 characters is
set ttyfast                     " fast terminal conn for faster redraw
set ttymouse=xterm2             " terminal type for mouse codes
set ttyscroll=3                 " speedup scrolling
set undodir=~/.config/nvim/undodir
set undofile
set wildignore=*/node_modules/*,*/tmp/*,*/.idea/*,*/.git/*
syntax enable
syntax on

" --- Plugins

call plug#begin('~/.config/nvim/plugged')

" General
Plug 'nvim-lualine/lualine.nvim'                   " Status line
Plug 'akinsho/bufferline.nvim'                     " Buffers
Plug 'machakann/vim-highlightedyank'               " Highlight yanked text
Plug 'kyazdani42/nvim-tree.lua'                    " File explorer
Plug 'folke/tokyonight.nvim', { 'branch': 'main' } " Color scheme
" Lsp
Plug 'neovim/nvim-lspconfig'
Plug 'jose-elias-alvarez/null-ls.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
" Autocompletion
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'onsails/lspkind-nvim'
" Git
Plug 'tpope/vim-fugitive'
Plug 'lewis6991/gitsigns.nvim'
" Telescope
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

call plug#end()

" --- Colors

highlight ColorColumn ctermbg=0 guibg=lightgrey

" --- Remaps

let mapleader = " "
let g:tmux_navigator_disable_when_zoomed = 1  " disable tmux nav when zoomed in


:inoremap jk <Esc>              " Map jk to Esc
:inoremap kj <Esc>              " Map kj to Esc
nnoremap <leader>p :Telescope find_files<Cr>
nnoremap <leader>b :NvimTreeToggle<Cr>
nnoremap <Up>    :resize +2<CR>     " Disable arrow movement, re-size splits
nnoremap <Down>  :resize -2<CR>     " instead.
nnoremap <Left>  :vertical resize +2<CR>
nnoremap <Right> :vertical resize -2<CR>
nmap <Leader>z [s1z=                " Correct last spelling issue
map <leader>ss :setlocal spell!<cr> " Toggle spell checking
nnoremap S :grep! "\b<C-R><C-W>\b"<CR>:cw<CR> " bind S to grep word under cursor
nnoremap <silent> <CR> :nohlsearch<CR><CR>

" ---  COMMIT MESSAGES

augroup gitcommit
  autocmd!
  autocmd Filetype gitcommit setlocal spell textwidth=72
augroup END

