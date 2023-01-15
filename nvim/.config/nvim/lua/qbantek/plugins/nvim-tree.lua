local setup, nvimtree = pcall(require, "nvim-tree")
if not setup then
  return
end

-- reccommended settings from nvim-tree documentation
vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

nvimtree.setup({
  actions = {
    open_file = {
      -- close the explorer when you open a file
      quit_on_open = true,
    }
  },
  renderer = {
    icons = {
      glyphs = {
        folder = {
          arrow_closed = '+',
          arrow_open= '-',
        },
      },
    },
  },
})
