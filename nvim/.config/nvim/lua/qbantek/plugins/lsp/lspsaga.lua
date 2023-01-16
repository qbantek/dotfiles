local saga_status, saga = pcall(require, "lspsaga")
if not saga_status then
  return
end

saga.setup({
  scroll_preview = {
		scroll_up = '<C-k>',
		scroll_down = '<C-j>',
	},
	--lsp finder
	finder = {
		edit = { '<CR>' },
	},
	-- peek definition
	definition = {
		edit = { '<CR>' },
	},
  symbol_in_winbar = {
    enable = false
  }
})
