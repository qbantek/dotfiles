call plug#begin('~/.config/nvim/plugged')

Plug 'nvim-lua/plenary.nvim' "libraries for nvim-lua

" LSP server configurations
Plug 'neovim/nvim-lspconfig' "collection of common configuration for nvim language server client.
Plug 'williamboman/nvim-lsp-installer' "seamlessly install LSP servers locally

" Nvim Completion
Plug 'hrsh7th/cmp-buffer' "nvim-cmp source for buffer words
Plug 'hrsh7th/cmp-path' "nvim-cmp source for path
Plug 'hrsh7th/cmp-cmdline' "nvim-cmp source for cmdline
Plug 'petertriho/cmp-git' "nvim-cmp source for git
Plug 'hrsh7th/cmp-vsnip' "nvim-cmp source for vim-vsnip
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/nvim-cmp' "completion engine plugin for neovim

" Vsnip
Plug 'hrsh7th/vim-vsnip' "snippet plugin for vim/nvim supporting LSP format
Plug 'hrsh7th/vim-vsnip-integ'

" Snippets
Plug 'rafamadriz/friendly-snippets' "collection of snippets for diff languages

" Navigation, Search, and Movement
Plug 'christoomey/vim-tmux-navigator'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate'}
Plug 'preservim/nerdtree'

" Coding
Plug 'AndrewRadev/splitjoin.vim'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'github/copilot.vim'
Plug 'tpope/vim-dadbod'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'vim-test/vim-test'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }

" Themes
Plug 'lifepillar/vim-solarized8'

" Misc
Plug 'wakatime/vim-wakatime'

call plug#end()

lua require('qbantek')
