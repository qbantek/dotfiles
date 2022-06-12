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
    -- NOTE: these are the names of the parsers and not the filetype.
    -- (for example if you want to disable highlighting for the `tex`
    -- filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    -- NOTE: highlighting in dart is causing a segmentation fault! - 06/19/2022
    disable = {
      "dart"
    },
    additional_vim_regex_highlighting = false,
  },
}
