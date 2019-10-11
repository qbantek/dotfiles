set encoding=utf-8

" Leader
let mapleader = " "

set tabstop=2     " 1 tab = 2 spaces
set shiftwidth=2  " text is indented 2 columns with re-indent operations
set softtabstop=2 " 1 tab = 2 spaces (insert mode)
set smarttab      " Uses shiftwidth instead of tabstop at start of lines
set expandtab     " Replaces tab with spaces

set hlsearch      " Highlight search results
set nojoinspaces  " Only one space after .
set background=dark
set ic            " Ignore case
set nowrap
set laststatus=2  " Always display the status line

set autowrite     " Automatically :write before running commands
set nobackup
set nowritebackup
set noswapfile

set spell spelllang=en_us
set modelines=0   " Disable modelines as a security precaution
set nomodeline    " Disable modelines as a security precaution

set number
set relativenumber
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

set ruler
set textwidth=80 " Make it obvious where 80 characters is
set colorcolumn=+1
highlight ColorColumn ctermbg=0 guibg=lightgrey

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

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

" UltiSnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

" This unsets the "last search pattern" register by hitting return 
:nnoremap <silent> <CR> :nohlsearch<CR><CR

" Map Ctrl-n to NERDTree
map <C-n> :NERDTreeToggle<CR>

" Map jk & kj to Esc
:inoremap jk <Esc>
:inoremap kj <Esc>

" Support for gem ctags
set tags=tags;
set tags+=gems.tags;

" Enable Elite mode, NO ARROWS!
let g:elite_mode=1

" Disable arrow movement, re-size splits instead.
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

