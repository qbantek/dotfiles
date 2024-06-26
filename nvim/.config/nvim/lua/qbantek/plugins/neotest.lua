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
    require("neotest").setup({
      adapters = {
        require("neotest-rspec"),
      },
    })
  end,
  -- config = function()
  --   local flatten = function(t)
  --     return vim.iter(t):flatten():totable()
  --   end
  --
  --   local opts = {
  --     enable = true,
  --     icons = {
  --       unknown = "",
  --     },
  --     status = { virtual_text = true },
  --     output = { open_on_run = true },
  --     quickfix = {
  --       open = function()
  --         -- if LazyVim.has("trouble.nvim") then
  --         --   require("trouble").open({ mode = "quickfix", focus = false })
  --         -- else
  --         vim.cmd("copen")
  --         -- end
  --       end,
  --     },
  --     adapters = {
  --       require("neotest-jest")({}),
  --       require("neotest-rspec")({
  --         rspec_command = function(position_type)
  --           if position_type == "test" then
  --             return flatten({
  --               "bundle",
  --               "exec",
  --               "rspec",
  --               "--fail-fast",
  --             })
  --           else
  --             return flatten({
  --               "bundle",
  --               "exec",
  --               "rspec",
  --             })
  --           end
  --         end,
  --       }),
  --     },
  --   }
  --
  --   require("neotest").setup(opts)
  -- end,
  --
  -- -- stylua: ignore
  -- keys = function()
  --   local neotest = require("neotest")
  --
  --   return {
  --     {"<leader>t", "", desc = "+test"},
  --     { "<leader>tt", function() neotest.run.run(vim.fn.expand("%")) end, desc = "Run File" },
  --     { "<leader>tT", function() neotest.run.run(vim.fn.getcwd()) end, desc = "Run All Test Files" },
  --     { "<leader>tr", function() neotest.run.run() end, desc = "Run Nearest" },
  --     { "<leader>tl", function() neotest.run.run_last() end, desc = "Run Last" },
  --     { "<leader>ts", function() neotest.summary.toggle() end, desc = "Toggle Summary" },
  --     { "<leader>to", function() neotest.output.open({ enter = true, auto_close = true }) end, desc = "Show Output" },
  --     { "<leader>tO", function() neotest.output_panel.toggle() end, desc = "Toggle Output Panel" },
  --     { "<leader>tS", function() neotest.run.stop() end, desc = "Stop" },
  --     { "<leader>tw", function() neotest.watch.toggle(vim.fn.expand("%")) end, desc = "Toggle Watch" },
  --   }
  -- end,
}
