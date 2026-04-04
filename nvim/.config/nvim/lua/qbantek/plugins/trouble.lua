return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VeryLazy",
  opts = {
    auto_close = false,
    auto_preview = true,
    focus = true,
  },
  keys = {
    { "<leader>DD", "<cmd>Trouble diagnostics toggle<cr>", desc = "Show workspace diagnostics in trouble" },
    { "<leader>Dd", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Show document diagnostics in trouble" },
    { "<leader>Dq", "<cmd>Trouble quickfix toggle<cr>", desc = "Show quickfix list in trouble" },
    { "<leader>Dl", "<cmd>Trouble loclist toggle<cr>", desc = "Show location list in trouble" },
    { "<leader>Dr", "<cmd>Trouble lsp_references toggle<cr>", desc = "Show LSP references in trouble" },
    { "<leader>Df", "<cmd>Trouble lsp_definitions toggle<cr>", desc = "Show LSP definitions in trouble" },
    { "<leader>Dt", "<cmd>Trouble lsp_type_definitions toggle<cr>", desc = "Show LSP type definitions in trouble" },
    { "<leader>Di", "<cmd>Trouble lsp_implementations toggle<cr>", desc = "Show LSP implementations in trouble" },
    { "<leader>Dc", "<cmd>Trouble close<cr>", desc = "Close trouble window" },
    { "<leader>Dx", "<cmd>Trouble refresh<cr>", desc = "Refresh trouble" },
    { "<leader>Dz", "<cmd>Trouble toggle<cr>", desc = "Toggle trouble window" },
  },
}
