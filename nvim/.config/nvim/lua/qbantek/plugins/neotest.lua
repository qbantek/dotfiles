return {
  "nvim-neotest/neotest",
  dependencies = {
    "antoinemadec/FixCursorHold.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-neotest/nvim-nio",
    "nvim-treesitter/nvim-treesitter",

    "olimorris/neotest-rspec",
  },
  config = function()
    local neotest = require("neotest")

    local keymap = {
      tt = {
        func = function()
          neotest.run.run(vim.fn.expand("%"))
        end,
        desc = "Run File",
      },
      tT = {
        func = function()
          neotest.run.run(vim.fn.getcwd())
        end,
        desc = "Run All Test Files",
      },
      tr = {
        func = function()
          neotest.run.run()
        end,
        desc = "Run Nearest",
      },
      tl = {
        func = function()
          neotest.run.run_last()
        end,
        desc = "Run Last",
      },
      ts = {
        func = function()
          neotest.summary.toggle()
        end,
        desc = "Toggle Summary",
      },
      to = {
        func = function()
          neotest.output.open({ enter = true, auto_close = true })
        end,
        desc = "Show Output",
      },
      tO = {
        func = function()
          neotest.output_panel.toggle()
        end,
        desc = "Toggle Output Panel",
      },
      tS = {
        func = function()
          neotest.run.stop()
        end,
        desc = "Stop",
      },
      tw = {
        func = function()
          neotest.watch.toggle(vim.fn.expand("%"))
        end,
        desc = "Toggle Watch",
      },
    }

    for k, v in pairs(keymap) do
      vim.keymap.set("n", "<leader>" .. k, v.func, { desc = v.desc })
    end

    -- Add which-key mappings
    local wk = require("which-key")
    wk.register({
      ["<Leader>"] = {
        t = {
          name = "+Test",
        },
      },
    })

    neotest.setup({
      adapters = {
        require("neotest-rspec"),
      },
    })
  end,
}
