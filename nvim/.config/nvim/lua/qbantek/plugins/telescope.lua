return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
    "nvim-tree/nvim-web-devicons",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    local themes = require("telescope.themes")

    telescope.setup({
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
        ["ui-select"] = {
          themes.get_dropdown({}),
        },
      },
      defaults = {
        path_display = { "truncate" },
        preview = {
          treesitter = false,
        },
        vimgrep_arguments = {
          "rg",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--hidden",
          "--glob=!.git/*",
          "--glob=!node_modules/*",
          "--glob=!tags",
          "--column",
          "--smart-case",
          "--trim",
          "--color=never",
        },
        file_ignore_patterns = { "dist", "%.cache/" },
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-q>"] = function(prompt_bufnr)
              actions.send_selected_to_qflist(prompt_bufnr)
              actions.open_qflist(prompt_bufnr)
            end,
            ["<ESC>"] = actions.close,
          },
        },
      },
    })

    telescope.load_extension("fzf")
    telescope.load_extension("ui-select")

    local keymap = vim.keymap
    keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
    keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
    keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
    keymap.set("n", "<leader>fw", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
    keymap.set("n", "<leader>fu", "<cmd>Telescope resume<cr>", { desc = "Resume previous Telescope search" })
    keymap.set("n", "<leader>fd", function()
      vim.diagnostic.open_float(0, { scope = "buffer" })
    end, { desc = "Show buffer diagnostics" })
  end,
}
