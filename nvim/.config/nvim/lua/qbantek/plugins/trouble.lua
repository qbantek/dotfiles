return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VeryLazy",
  config = function()
    local trouble = require("trouble")
    local keymap = vim.keymap

    trouble.setup({
      -- your configuration can be added here
      -- see :help trouble.setup()
      auto_open = false, -- do not auto open
      auto_close = false, -- do not auto close
      auto_preview = true, -- automatically preview the location of the diagnostic
      auto_fold = false, -- automatically fold the file tree on open
      signs = {
        -- icons / text used for a diagnostic
        error = "󰅚",
        warning = "󰀪",
        hint = "󰌶",
        information = "󰋽",
        other = "󰗡",
      },
      use_diagnostic_signs = false, -- enabling this will use the signs defined in your lsp client
      -- Show empty lists instead of "No results"
      mode = "workspace_diagnostics", -- "workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references", "loclist"
      filter = {}, -- filter diagnostics (see :help trouble.setup.filter)
      severity = nil, -- nil (ALL) or vim.diagnostic.severity.ERROR | WARN | INFO | HINT
      group = true, -- group diagnostics by file
      padding = true, -- add an extra new line on top of the list
      cycle_results = true, -- cycle item list when reaching beginning or end of list
      action_keys = {
        -- key mappings for actions in the trouble list
        -- map to {} to remove a mapping, for example:
        -- close = {},
        close = { "q", "<esc>" }, -- close the list with q or esc
        cancel = "<esc>", -- cancel the preview and get back to your last window / buffer / cursor
        refresh = "r", -- manually refresh
        jump = { "<cr>", "<tab>" }, -- jump to the diagnostic or open / close folds
        open_split = { "<c-x>" }, -- open buffer in new split
        open_vsplit = { "<c-v>" }, -- open buffer in new vsplit
        open_tab = { "<c-t>" }, -- open buffer in new tabpage
        jump_close = { "o" }, -- jump to the diagnostic and close the list
        toggle_mode = "m", -- toggle between "workspace" and "document" diagnostics mode
        toggle_preview = "P", -- toggle auto_preview
        hover = "K", -- opens a small popup with the full multiline message
        preview = "p", -- preview the diagnostic location
        close_folds = { "zM", "zm" }, -- close all folds
        open_folds = { "zR", "zr" }, -- open all folds
        toggle_fold = { "zA", "za" }, -- toggle fold of current file
        previous = "k", -- previous item
        next = "j", -- next item
      },
    })

    -- Keymaps following your existing patterns
    local opts = { noremap = true, silent = true }

    -- Trouble diagnostics (replaces your current <leader>D telescope diagnostics)
    opts.desc = "Show diagnostics in trouble"
    keymap.set("n", "<leader>D", "<cmd>Trouble diagnostics toggle<cr>", opts)

    -- Trouble workspace diagnostics
    opts.desc = "Show workspace diagnostics in trouble"
    keymap.set("n", "<leader>Dw", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", opts)

    -- Trouble document diagnostics
    opts.desc = "Show document diagnostics in trouble"
    keymap.set("n", "<leader>Dd", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", opts)

    -- Trouble quickfix
    opts.desc = "Show quickfix list in trouble"
    keymap.set("n", "<leader>Dq", "<cmd>Trouble quickfix toggle<cr>", opts)

    -- Trouble location list
    opts.desc = "Show location list in trouble"
    keymap.set("n", "<leader>Dl", "<cmd>Trouble loclist toggle<cr>", opts)

    -- Trouble LSP references (alternative to your gR telescope)
    opts.desc = "Show LSP references in trouble"
    keymap.set("n", "<leader>Dr", "<cmd>Trouble lsp_references toggle<cr>", opts)

    -- Trouble LSP definitions (alternative to your gd telescope)
    opts.desc = "Show LSP definitions in trouble"
    keymap.set("n", "<leader>Df", "<cmd>Trouble lsp_definitions toggle<cr>", opts)

    -- Trouble LSP type definitions (alternative to your gt telescope)
    opts.desc = "Show LSP type definitions in trouble"
    keymap.set("n", "<leader>Dt", "<cmd>Trouble lsp_type_definitions toggle<cr>", opts)

    -- Trouble LSP implementations (alternative to your gi telescope)
    opts.desc = "Show LSP implementations in trouble"
    keymap.set("n", "<leader>Di", "<cmd>Trouble lsp_implementations toggle<cr>", opts)

    -- Close trouble window
    opts.desc = "Close trouble window"
    keymap.set("n", "<leader>Dc", "<cmd>Trouble close<cr>", opts)

    -- Refresh trouble
    opts.desc = "Refresh trouble"
    keymap.set("n", "<leader>Dx", "<cmd>Trouble refresh<cr>", opts)

    -- Toggle trouble (close if open, open if closed)
    opts.desc = "Toggle trouble window"
    keymap.set("n", "<leader>Dz", "<cmd>Trouble toggle<cr>", opts)
  end,
}