local opt = vim.opt -- for conciseness

-- line numbers
opt.relativenumber = true -- show relative line numbers
opt.number = true -- shows absolute line number on cursor line

-- tabs & indentation
opt.tabstop = 2 -- 2 spaces for tabs (prettier default)
opt.shiftwidth = 2 -- 2 spaces for indent width
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting new one
opt.textwidth = 80 -- wrap text at 80 characters

-- line wrapping
opt.wrap = false -- disable line wrapping

-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive

-- cursor line
opt.cursorline = true -- highlight the current cursor line

-- appearance

-- turn on termguicolors for nightfly colorscheme to work
-- (have to use iterm2 or any other true color terminal)
opt.termguicolors = true -- enable 24-bit RGB color in the TUI
opt.background = "dark" -- colorschemes that can be light or dark will be made dark
opt.signcolumn = "yes" -- show sign column so that text doesn't shift
opt.showmatch = true -- show matching brackets
opt.colorcolumn = "+1" -- highlight column after 80 characters
opt.visualbell = true -- use visual bell instead of beeping

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

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
