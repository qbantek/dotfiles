return {
  "neovim/nvim-lspconfig",
  lazy = false,
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
  },
  config = function()
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    vim.diagnostic.config({
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = "E",
          [vim.diagnostic.severity.WARN] = "W",
          [vim.diagnostic.severity.HINT] = "󰠠 ",
          [vim.diagnostic.severity.INFO] = "i",
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

    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(ev)
        local bufnr = ev.buf
        local function map(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, noremap = true, silent = true, desc = desc })
        end

        map("n", "gR", "<cmd>Telescope lsp_references<CR>", "Show LSP references")
        map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
        map("n", "gd", "<cmd>Telescope lsp_definitions<CR>", "Show LSP definitions")
        map("n", "gi", "<cmd>Telescope lsp_implementations<CR>", "Show LSP implementations")
        map("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", "Show LSP type definitions")
        map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "See available code actions")
        map("n", "<leader>rn", vim.lsp.buf.rename, "Smart rename")
        map("n", "<leader>d", vim.diagnostic.open_float, "Show line diagnostics")
        map("n", "K", vim.lsp.buf.hover, "Show documentation for what is under cursor")
        map("i", "<C-s>", vim.lsp.buf.signature_help, "Signature help")
        map("n", "<leader>ih", function()
          vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }), { bufnr = bufnr })
        end, "Toggle inlay hints")
        map("n", "<leader>rs", ":LspRestart<CR>", "Restart LSP")
      end,
    })

    local capabilities = cmp_nvim_lsp.default_capabilities()

    local servers = {
      "cssls",
      "dockerls",
      "gopls",
      "herb_ls",
      "html",
      "ruby_lsp",
      "ts_ls",
      "yamlls",
    }
    for _, server in ipairs(servers) do
      vim.lsp.config(server, {
        capabilities = capabilities,
      })
    end

    vim.lsp.config("lua_ls", {
      capabilities = capabilities,
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
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

    vim.lsp.config("stylua", {
      cmd = { "false" },
      filetypes = {},
    })

    vim.lsp.enable({
      "cssls",
      "dockerls",
      "gopls",
      "herb_ls",
      "html",
      "lua_ls",
      "ruby_lsp",
      "ts_ls",
      "yamlls",
    })
  end,
}
