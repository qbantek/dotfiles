local M = {}

function M.setup()
    vim.g["test#strategy"] = "neovim"
    vim.g["test#ruby#rspec#options"] = {
        nearest = "--backtrace",
        file = "--format documentation",
        suite = "--tag ~slow",
    }
    vim.api.nvim_set_keymap("n", "<leader>t", ":TestNearest<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<leader>T", ":TestFile<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<leader>a", ":TestSuite<CR>", { noremap = true, silent = true })
end

return M

