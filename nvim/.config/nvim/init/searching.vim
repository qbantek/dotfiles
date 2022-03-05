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
nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>
let NERDTreeShowHidden=1
let NERDTreeQuitOnOpen=1
let NERDTreeIgnore=['\.py[cd]$', '\~$', '\.swo$', '\.swp$', '^\.git$', '^\.hg$', '^\.svn$', '\.bzr$']
let NERDTreeStatusline="%{exists('b:NERDTree')?fnamemodify(b:NERDTree.root.path.str(), ':~'):''}"

