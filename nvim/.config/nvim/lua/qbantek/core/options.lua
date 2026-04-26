local opt = vim.opt -- for conciseness

-- line numbers
opt.relativenumber = true -- show relative line numbers
opt.number = true -- shows absolute line number on cursor line

-- tabs & indentation
opt.tabstop = 2 -- 2 spaces for tabs (prettier default)
opt.shiftwidth = 2 -- 2 spaces for indent width
opt.expandtab = true
opt.textwidth = 80

-- line wrapping
opt.wrap = false -- disable line wrapping

-- folding
opt.foldlevel = 1 -- keep top-level folds open and nested folds closed
opt.foldlevelstart = 1 -- apply the same fold level when opening a buffer

-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive

-- cursor line
opt.cursorline = true -- highlight the current cursor line

-- appearance

opt.background = "dark"
opt.signcolumn = "yes" -- show sign column so that text doesn't shift
opt.showmatch = true -- show matching brackets
opt.colorcolumn = "+1" -- highlight column after 80 characters
opt.visualbell = true -- use visual bell instead of beeping

-- clipboard
opt.clipboard:append("unnamedplus") -- use system clipboard as default register

-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

-- Don't use swapfile. It's slow.
opt.swapfile = false -- disable swap file
opt.backup = false -- disable backup file
opt.writebackup = false -- disable backup before writing

-- ignore files when expanding wildcards
opt.wildignore = opt.wildignore + {
  "**/.git/*",
  "**/coverage/*",
  "**/node_modules/*",
  "**/tmp/*",
}
