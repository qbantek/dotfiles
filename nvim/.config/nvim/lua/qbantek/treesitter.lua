require 'nvim-treesitter.configs'.setup {
  ensure_installed = {
    "bash",
    "css",
    "c_sharp",
    "dart",
    "dockerfile",
    "go",
    "gomod",
    "html",
    "javascript",
    "json",
    "lua",
    "make",
    "markdown",
    "python",
    "regex",
    "ruby",
    "scss",
    "typescript",
    "vim",
    "yaml"
  },
  sync_install = false,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}
