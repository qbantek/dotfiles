return {
  "williamboman/mason.nvim",
  dependencies = {
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
      -- list of servers for mason to install
      ensure_installed = {
        "astro",
        "cssls",
        "dockerls",
        "gopls", -- Go language server
        "html",
        "lua_ls",
        "ts_ls",
        "yamlls",
      },
      -- auto-install configured servers (with lspconfig)
      automatic_installation = true, -- not the same as ensure_installed
      -- exclude tools that are not LSP servers
      exclude = { "stylua", "copilot" },
    })

    pcall(mason_tool_installer.setup, {
      -- a list of all tools you want to ensure are installed upon
      -- start; they should be the names Mason uses for each tool
      ensure_installed = {
        "eslint_d", -- js linter
        "goimports", -- Go imports tool
        "gofumpt", -- Go code formatter
        "prettier", -- prettier formatter
        "stylua", -- lua formatter
        "yamlfix", -- yaml formatter
      },
    })
  end,
}
