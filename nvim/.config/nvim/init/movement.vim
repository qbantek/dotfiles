" Map jk to Esc, easier to type
inoremap jk <Esc>

" Disable arrow movement, re-size splits instead.
nnoremap <Up>    :resize +2<CR>
nnoremap <Down>  :resize -2<CR>
nnoremap <Left>  :vertical resize +2<CR>
nnoremap <Right> :vertical resize -2<CR>

" disable tmux navigation when zoomed in
let g:tmux_navigator_disable_when_zoomed = 1

