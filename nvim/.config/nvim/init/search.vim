" suspend `hlsearch` highlighting
nnoremap <silent> <CR> :nohlsearch<CR><CR>

" Scroll the screen and do not move the cursor when jumping to next result
nnoremap n nzzzv
nnoremap N Nzzzv

" Substitutes the current word
nnoremap <C-w><C-r> :%s/<C-r><C-w>//g<LEFT><LEFT>

" Map Ctrl-n to NERDTree
nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>
let NERDTreeShowHidden=1
let NERDTreeQuitOnOpen=1
let NERDTreeIgnore=['\.py[cd]$', '\~$', '\.swo$', '\.swp$', '^\.git$', '^\.hg$', '^\.svn$', '\.bzr$']
let NERDTreeStatusline="%{exists('b:NERDTree')?fnamemodify(b:NERDTree.root.path.str(), ':~'):''}"

