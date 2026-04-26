return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    dependencies = {
      "windwp/nvim-ts-autotag",
    },
    config = function()
      local install_dir = vim.fn.stdpath("data") .. "/tree-sitter"
      require("nvim-treesitter").setup({
        install_dir = install_dir,
      })

      vim.treesitter.language.register("embedded_template", { "eruby" })
      vim.treesitter.language.register("tsx", { "typescriptreact", "javascriptreact" })
      vim.treesitter.language.register("bash", { "sh" })

      require("nvim-treesitter").install({
        "bash",
        "css",
        "diff",
        "dockerfile",
        "embedded_template",
        "gitignore",
        "go",
        "gomod",
        "gowork",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "query",
        "ruby",
        "scss",
        "tsx",
        "typescript",
        "vim",
        "yaml",
      })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "bash",
          "sh",
          "css",
          "diff",
          "dockerfile",
          "eruby",
          "gitignore",
          "go",
          "gomod",
          "gowork",
          "html",
          "javascript",
          "javascriptreact",
          "json",
          "lua",
          "markdown",
          "query",
          "ruby",
          "scss",
          "typescript",
          "typescriptreact",
          "vim",
          "yaml",
        },
        callback = function(ev)
          pcall(vim.treesitter.start, ev.buf)
          vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
          vim.wo[0][0].foldmethod = "expr"
          vim.wo[0][0].foldlevel = 1
          vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })

      require("nvim-ts-autotag").setup()
    end,
  },
}
