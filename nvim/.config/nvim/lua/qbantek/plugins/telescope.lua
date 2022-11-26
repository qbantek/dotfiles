local telescope_setup, telescope = pcall(require, "telescope")
if not telescope_setup then
  return
end

-- import telescope actions safely
local actions_setup, actions = pcall(require, "telescope.actions")
if not actions_setup then
  return
end

-- import telescope actions safely
local sorters_setup, sorters = pcall(require, "telescope.sorters")
if not sorters_setup then
  return
end

-- configure telescope
telescope.setup({
  -- custom mappings
  defaults = {
    file_sorter = sorters.get_fzy_sorter,
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
        ["<C-k>"] = actions.move_selection_previous, -- move to prev result
        ["<C-j>"] = actions.move_selection_next, -- move to next result
        ["<C-q>"] = actions.send_selected_to_qflist+actions.open_qflist, -- send selected to quickfixlist
        ["<ESC>"] = actions.close,
      },
    },
  },
  extensions = {
    fzy_native = {
      override_generic_sorter = false,
      override_file_sorter = true
    }
  }
})

telescope.load_extension("fzf")
