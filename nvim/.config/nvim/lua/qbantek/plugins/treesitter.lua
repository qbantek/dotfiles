local status, treesitter = pcall(require, "nvim-treesitter.configs")
if not status then
  return
end

-- configure treesitter
treesitter.setup({
  highlight = {
    enable = true,
  },
  indent = { enable = true },
  autotag = { enable = true },
  ensure_installed = {
    "bash",
    "css",
    "dockerfile",
    "gitignore",
    "go",
    "gomod",
    "html",
    "javascript",
    "json",
    "lua",
    "make",
    "markdown",
    "markdown_inline",
    "regex",
    "ruby",
    "scss",
    "tsx",
    "typescript",
    "vim",
    "vimdoc",
    "yaml",
  },
  auto_install = true,
})
