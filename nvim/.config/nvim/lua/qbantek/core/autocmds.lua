local autocmd = vim.api.nvim_create_autocmd

autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    local excluded = { markdown = true, text = true }
    if not excluded[vim.bo.filetype] then
      vim.cmd([[:%s/\s\+$//e]])
    end
  end,
})

autocmd("FileType", {
  pattern = "*",
  callback = function()
    vim.opt_local.formatoptions:remove({ "c", "r", "o" })
  end,
})

autocmd("TextYankPost", {
  desc = "Highlight yanked text",
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
  end,
})

autocmd("TermOpen", {
  desc = "Configure terminal buffer",
  command = "setlocal listchars= nonumber norelativenumber nocursorline",
})

autocmd("TermOpen", {
  desc = "Set terminal to insert mode",
  pattern = "term://*",
  command = "startinsert",
})

autocmd("BufLeave", {
  pattern = "term://*",
  command = "stopinsert",
})

autocmd("FileType", {
  pattern = "TelescopeResults",
  command = [[setlocal nofoldenable]],
})

vim.api.nvim_create_autocmd("BufWinEnter", {
  group = vim.api.nvim_create_augroup("help_window_right", {}),
  pattern = { "*.txt" },
  callback = function()
    if vim.o.filetype == "help" then
      vim.cmd.wincmd("L")
    end
  end,
})

vim.filetype.add({
  pattern = {
    [".*%.yaml%.erb"] = "yaml",
    [".*%.yml%.erb"] = "yaml",
  },
})
