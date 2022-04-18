source ~/.config/nvim/init/git.vim
source ~/.config/nvim/init/movement.vim
source ~/.config/nvim/init/settings.vim

" colors
set termguicolors
augroup highlight_yank
  autocmd!
  autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank()
augroup END
colorscheme default
