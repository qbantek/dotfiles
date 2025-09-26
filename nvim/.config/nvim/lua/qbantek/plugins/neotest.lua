return {
  "nvim-neotest/neotest",
  dependencies = {
    "antoinemadec/FixCursorHold.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-neotest/nvim-nio",
    "nvim-treesitter/nvim-treesitter",
    {
      "fredrikaverpil/neotest-golang",
      dependencies = {
        "uga-rosa/utf8.nvim", -- Required for neotest-golang
        "nvim-neotest/nvim-nio", -- Required for neotest-golang
      },
      version = "*",
    },
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
          neotest.run.run({ suite = true })
          -- neotest.run.run(vim.fn.getcwd())
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

    local neotest_golang_opts = { sanitize_output = true } -- Specify custom configuration
    neotest.setup({
      adapters = {
        require("neotest-rspec"),
        require("neotest-golang")(neotest_golang_opts), -- Registration
      },
    })
  end,
}
