return {
  "williamboman/mason.nvim",
  dependencies = {
    "neovim/nvim-lspconfig",
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    -- import mason
    local mason = require("mason")

    -- import mason-lspconfig
    local mason_lspconfig = require("mason-lspconfig")

    -- import mason-tool-installer
    local mason_tool_installer = require("mason-tool-installer")

    -- enable mason and configure icons
    pcall(mason.setup, {
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    pcall(mason_lspconfig.setup, {
      ensure_installed = {
        "cssls",
        "dockerls",
        "gopls",
        "herb_ls",
        "html",
        "lua_ls",
        "ts_ls",
        "yamlls",
      },
      automatic_installation = true,
      automatic_enable = false,
    })

    pcall(mason_tool_installer.setup, {
      -- a list of all tools you want to ensure are installed upon
      -- start; they should be the names Mason uses for each tool
      ensure_installed = {
        "erb-formatter",
        "eslint_d", -- js linter
        "goimports", -- Go imports tool
        "gofumpt", -- Go code formatter
        "htmlbeautifier",
        "prettier",
        "prettierd",
        "stylua", -- lua formatter
        "yamlfix", -- yaml formatter
      },
    })
  end,
}
