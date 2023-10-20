return {
  {
    'overcache/NeoSolarized',
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- load colorscheme here
      vim.cmd([[colorscheme Neosolarized]])
    end,
  },
}
