return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
  },
  config = function()
    -- import cmp-nvim-lsp plugin
    local cmp_nvim_lsp = require("cmp_nvim_lsp")
    -- Load LSP configurations (not the deprecated lspconfig module)
    pcall(require, "lspconfig.configs")

    local keymap = vim.keymap -- for conciseness

    -- Configure diagnostic signs using the new approach
    vim.diagnostic.config({
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = " ",
          [vim.diagnostic.severity.WARN] = " ",
          [vim.diagnostic.severity.HINT] = "󰠠 ",
          [vim.diagnostic.severity.INFO] = " ",
        },
      },
      virtual_text = true,
      update_in_insert = true,
      underline = true,
      severity_sort = true,
      float = {
        focused = false,
        style = "minimal",
        border = "rounded",
        source = true,
        header = "",
        prefix = "",
      },
    })

    local opts = { noremap = true, silent = true }
    local on_attach = function(_, bufnr)
      opts.buffer = bufnr

      -- set keybinds
      opts.desc = "Show LSP references"
      keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

      opts.desc = "Go to declaration"
      keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

      opts.desc = "Show LSP definitions"
      keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

      opts.desc = "Show LSP implementations"
      keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

      opts.desc = "Show LSP type definitions"
      keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

      opts.desc = "See available code actions"
      keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

      opts.desc = "Smart rename"
      keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

      opts.desc = "Show buffer diagnostics"
      keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

      opts.desc = "Show line diagnostics"
      keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

      -- opts.desc = "Go to previous diagnostic"
      -- keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

      -- opts.desc = "Go to next diagnostic"
      -- keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

      opts.desc = "Show documentation for what is under cursor"
      keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

      opts.desc = "Restart LSP"
      keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
    end

    -- used to enable autocompletion (assign to every lsp server config)
    local capabilities = cmp_nvim_lsp.default_capabilities()

    -- configure lsp servers
    local servers = {
      "astro",
      "cssls",
      "dockerls",
      "gopls",
      "html",
      "ts_ls",
      "yamlls",
    }
    for _, server in ipairs(servers) do
      vim.lsp.config(server, {
        capabilities = capabilities,
        on_attach = on_attach,
      })
    end

    -- custom configure solargraph server
    vim.lsp.config("solargraph", {
      cmd = {
        "bundle",
        "exec",
        "solargraph",
        "stdio",
      },
      filetypes = { "ruby" },
      flags = { debounce_text_changes = 150 },
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        solargraph = {
          autoformat = true,
          completion = true,
          definitions = true,
          diagnostics = true,
          folding = true,
          references = true,
          rename = true,
          symbols = true,
        },
      },
    })

    -- custom configure lua server
    vim.lsp.config("lua_ls", {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = { -- custom settings for lua
        Lua = {
          -- make the language server recognize "vim" global
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            -- make language server aware of runtime files
            library = {
              [vim.fn.expand("$VIMRUNTIME/lua")] = true,
              [vim.fn.stdpath("config") .. "/lua"] = true,
            },
            checkThirdParty = false,
          },
          runtime = {
            version = "LuaJIT",
            path = vim.split(package.path, ";"),
          },
        },
      },
    })

    -- Disable stylua LSP server (stylua is a formatter, not an LSP server)
    -- The nvim-lspconfig package incorrectly includes stylua as an LSP server
    vim.lsp.config("stylua", {
      cmd = { "false" }, -- This will prevent stylua from being used as LSP server
      filetypes = {}, -- No filetypes, effectively disabling it
    })
  end,
}
