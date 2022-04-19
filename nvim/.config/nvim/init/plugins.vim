call plug#begin('~/.config/nvim/plugged')

Plug 'nvim-lua/plenary.nvim' "libraries for nvim-lua

" Completion and snippets
Plug 'neovim/nvim-lspconfig' "collection of common configuration for nvim language server client.
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/cmp-copilot'
Plug 'hrsh7th/nvim-cmp'
Plug 'petertriho/cmp-git'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
Plug 'williamboman/nvim-lsp-installer' "seamlessly install LSP servers locally
Plug 'windwp/lsp-fastaction.nvim' "map lsp code action to key & sort the code action
Plug 'rafamadriz/friendly-snippets' "collection of snippets for diff languages

Plug 'AndrewRadev/splitjoin.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'akinsho/flutter-tools.nvim'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'github/copilot.vim'
Plug 'lifepillar/vim-solarized8'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate'}
Plug 'preservim/nerdtree'
Plug 'tpope/vim-dadbod'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'vim-test/vim-test'
Plug 'wakatime/vim-wakatime'

call plug#end()

lua require('qbantek')
