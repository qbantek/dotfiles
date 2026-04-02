local keymap = vim.keymap

---------------------
-- General Keymaps --
---------------------

-- use jk to exit insert mode
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

keymap.set("n", "<CR>", function()
  local buftype = vim.bo.buftype
  if buftype == "quickfix" or buftype == "loclist" then
    return "<CR>"
  end
  return "<cmd>nohl<CR>"
end, { expr = true, desc = "Clear search highlights" })

-- delete single character without copying into register
keymap.set("n", "x", '"_x')

-- rename the word under the cursor
keymap.set(
  "n",
  "<leader>rw",
  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  { desc = "Rename word under cursor" }
)
