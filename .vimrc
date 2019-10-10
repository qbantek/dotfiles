set encoding=utf-8

" Leader
let mapleader = " "

" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set softtabstop=2
set smarttab
set expandtab

set hlsearch
set nojoinspaces
set background=dark
set ic            " Ignore case
set nowrap
set laststatus=2  " Always display the status line

set autowrite     " Automatically :write before running commands
set nobackup
set nowritebackup
set noswapfile

set history=50
set spell spelllang=en_us
set modelines=0   " Disable modelines as a security precaution
set nomodeline

set relativenumber
set number
set ruler
set textwidth=80 " Make it obvious where 80 characters is
set colorcolumn=+1
highlight ColorColumn ctermbg=0 guibg=lightgrey

syntax enable
syntax on

if filereadable(expand("~/.vimrc.bundles"))
    source ~/.vimrc.bundles
endif

" this tells vim-rspec to use Send_to_Tmux to run the selected specs.
let g:rspec_command = 'call Send_to_Tmux("rspec {spec}\n")'

" Command-T
map <Leader>e <Plug>(CommandT)

" vim-rspec mappings
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>

" vim-rubocop
nmap <Leader>ra :RuboCop -a<CR>

" YouCompleteMe
let g:ycm_key_list_select_completion = ['<C-j>']
let g:ycm_key_list_previous_completion = ['<C-k>']

" Trigger configuration. Do not use <tab> if you use
" https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

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

let vim_markdown_preview_github=1

augroup markdownSpell
    autocmd!
    autocmd FileType markdown setlocal spell
    autocmd BufRead,BufNewFile *.md setlocal spell
augroup END

