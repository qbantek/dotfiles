local actions = require("telescope.actions")

require("telescope").setup {
  defaults = {
    file_sorter = require('telescope.sorters').get_fzy_sorter,
    prompt_prefix = '> ',
    vimgrep_arguments = {
      "rg",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--hidden",
      "--glob=!.git/*",
      "--column",
      "--smart-case",
      "--trim" -- add this value
    },

    mappings = {
      i = {
        ["<esc>"] = actions.close
      },
    },
  },
  extensions = {
    fzy_native = {
      override_generic_sorter = false,
      override_file_sorter = true
    }
  }
}

require('telescope').load_extension('fzf')
require("telescope").load_extension("flutter")
