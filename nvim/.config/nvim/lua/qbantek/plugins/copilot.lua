return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",
  config = function()
    require("copilot").setup({
      filetypes = {
        markdown = true,
        yaml = true,
        json = true,
        toml = true,
      },
    })
  end,
}
