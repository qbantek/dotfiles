return {
  "github/copilot.vim", -- copilot, need to say more?
  lazy = true,
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    vim.keymap.set("i", "<leader> cc", "<cmd>Copilot pane<CR>", { desc = "Open Copilot pane" })
    vim.keymap.set("i", "<leader> cd", "<Plug>(copilot-dissmiss)", { desc = "Dismiss Copilot suggestion" })
    vim.keymap.set("i", "<leader> cs", "<Plug>(copilot-suggest)", { desc = "Explicitly request a  Copilot suggestion" })

    vim.keymap.set("i", "<leader> cn", "<Plug>(copilot-next)", { desc = "Navigate to next Copilot suggestion" })
    vim.keymap.set("i", "<leader> cp", "<Plug>(copilot-previous)", { desc = "Navigate to previous Copilot suggestion" })

    vim.keymap.set(
      "i",
      "<leader> cl",
      "<Plug>(copilot-accept-line)",
      { desc = "Accept the next line of the Copilot suggestion" }
    )
    vim.keymap.set(
      "i",
      "<leader> cw",
      "<Plug>(copilot-accept-word)",
      { desc = "Accept the next word of the Copilot suggestion" }
    )
  end,
}
