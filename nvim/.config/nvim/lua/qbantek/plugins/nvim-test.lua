local g = vim.g
local api = vim.api

g["test#javascript#jest#options"] = "--watch --notify --notify-mode=change"
g["test#ruby#rspec#options"] = {
  file = "--format documentation",
}
g['test#strategy'] = {
  nearest = 'dispatch_background',
  file = 'dispatch_background',
  suite = 'dispatch_background',
}

-- keymaps
api.nvim_set_keymap("n", "<leader>tt", ":TestNearest<CR>", { noremap = true, silent = true })
api.nvim_set_keymap("n", "<leader>tf", ":TestFile<CR>", { noremap = true, silent = true })
api.nvim_set_keymap("n", "<leader>ta", ":TestSuite<CR>", { noremap = true, silent = true })
