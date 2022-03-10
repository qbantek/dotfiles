" code_action 
nnoremap <space>ca  <cmd>lua require("lsp-fastaction").code_action()<CR>
vnoremap <space>ca  <esc><cmd>lua require('lsp-fastaction').range_code_action()<CR>
