return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
    dependencies = {
      -- "nvim-treesitter/nvim-treesitter-textobjects",
      "windwp/nvim-ts-autotag",
    },
    config = function()
      require("nvim-treesitter").setup({
        indent = { enable = true },
        autotag = {
          enable = true,
        },
        ensure_installed = {
          "bash",
          "css",
          "dockerfile",
          "gitignore",
          "go",
          "html",
          "javascript",
          "json",
          "lua",
          "markdown",
          "markdown_inline",
          "query",
          "ruby",
          "tsx",
          "typescript",
          "vim",
          "yaml",
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<C-space>",
            node_incremental = "<C-space>",
            scope_incremental = false,
            node_decremental = "<bs>",
          },
        },
      })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "*",
        callback = function()
          local filetype = vim.bo.filetype
          if filetype:match("^Telescope") then
            return
          end
          if vim.treesitter.language.get_lang(filetype) then
            pcall(vim.treesitter.start)
          end
        end,
      })

      -- enable nvim-ts-context-commentstring plugin for commenting tsx and jsx
      -- require('ts_context_commentstring').setup {}
    end,
  },
}
