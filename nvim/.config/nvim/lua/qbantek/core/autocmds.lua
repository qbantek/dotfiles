local augroup = vim.api.nvim_create_augroup -- Create/get autocommand group
local autocmd = vim.api.nvim_create_autocmd -- Create autocommand

-- Highlight on yank
augroup("YankHighlight", { clear = true })
autocmd("TextYankPost", {
  group = "YankHighlight",
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = "1000" })
  end,
})

-- Lint on save
autocmd({ "BufWritePost" }, {
  callback = function()
    -- try_lint without arguments runs the linters defined in `linters_by_ft`
    -- for the current filetype
    require("lint").try_lint()
  end,
})

-- Remove whitespace on save
autocmd("BufWritePre", {
  pattern = "",
  command = ":%s/\\s\\+$//e",
})

-- Don't auto commenting new lines
autocmd("BufEnter", {
  pattern = "",
  command = "set fo-=c fo-=r fo-=o",
})

-- Enter insert mode when switching to terminal
autocmd("TermOpen", {
  command = "setlocal listchars= nonumber norelativenumber nocursorline",
})

autocmd("TermOpen", {
  pattern = "",
  command = "startinsert",
})

-- Close terminal buffer on process exit
autocmd("BufLeave", {
  pattern = "term://*",
  command = "stopinsert",
})

-- Disable folding in Telescope's result window.
autocmd("FileType", {
  pattern = "TelescopeResults",
  command = [[setlocal nofoldenable]],
})
