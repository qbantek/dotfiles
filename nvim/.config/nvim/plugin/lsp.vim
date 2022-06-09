autocmd BufWritePre *.rb lua vim.lsp.buf.formatting_sync(nil, 1000)
autocmd BufWritePre *.go lua vim.lsp.buf.formatting_sync(nil, 1000)
autocmd BufWritePre *.js lua vim.lsp.buf.formatting_sync(nil, 1000)
autocmd BufWritePre *.lua lua vim.lsp.buf.formatting_sync(nil, 1000)
autocmd BufWritePre *.vim lua vim.lsp.buf.formatting_sync(nil, 1000)

augroup lspsaga_filetypes
  autocmd!
  autocmd FileType LspsagaCodeAction nnoremap <buffer><nowait><silent> <Esc> <cmd>close!<cr>
  autocmd FileType LspsagaDiagnostic nnoremap <buffer><nowait><silent> <Esc> <cmd>close!<cr>
  autocmd FileType LspsagaFinder nnoremap <buffer><nowait><silent> <Esc> <cmd>close!<cr>
  autocmd FileType LspsagaFloaterm nnoremap <buffer><nowait><silent> <Esc> <cmd>close!<cr>
  autocmd FileType LspsagaHover nnoremap <buffer><nowait><silent> <Esc> <cmd>close!<cr>
  autocmd FileType LspsagaRename nnoremap <buffer><nowait><silent> <Esc> <cmd>close!<cr>
  autocmd FileType LspsagaSignatureHelp nnoremap <buffer><nowait><silent> <Esc> <cmd>close!<cr>
augroup END

" float terminal also you can pass the cli command in open_float_terminal function
" Ctrl-f will open the term, and in term mode, it will kill the term
nnoremap <silent> <C-t> :Lspsaga toggle_floaterm<CR>
tnoremap <silent> <C-t> <C-\><C-n>:Lspsaga close_floaterm<CR>
