local opt = vim.opt

-- line numbers
opt.relativenumber = true
opt.number = true

-- tabs and indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true
opt.textwidth = 80

-- line wrapping
opt.wrap = false

-- search settings
opt.ignorecase = true
opt.smartcase = true

-- cursor line
opt.cursorline = true

-- appeareance
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"
opt.showmatch = true
opt.colorcolumn = '+1'
opt.visualbell = true

-- backspace
opt.backspace = "indent,eol,start"

-- clipboard
opt.clipboard:append("unnamedplus")

-- splits
opt.splitright = true
opt.splitbelow = true

-- Don't use swapfile
opt.swapfile = false
opt.backup = false
opt.writebackup = false

-- ignore files when expanding wildcards
opt.wildignore = opt.wildignore + {
  "**/.git/*",
  "**/coverage/*",
  "**/node_modules/*",
  "**/tmp/*",
}
