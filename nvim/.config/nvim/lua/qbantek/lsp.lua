local lsp_installer = require("nvim-lsp-installer")

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

---@diagnostic disable-next-line: unused-local
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings
  local opts = { noremap = true, silent = true }
  buf_set_keymap("n", "<space>rn", "<cmd>Lspsaga rename<cr>", opts)
  buf_set_keymap("n", "ca", "<cmd>Lspsaga code_action<cr>", opts)
  buf_set_keymap("x", "ca", ":<c-u>Lspsaga range_code_action<cr>", opts)
  buf_set_keymap("n", "K", "<cmd>Lspsaga hover_doc<cr>", opts)
  buf_set_keymap("n", "go", "<cmd>Lspsaga show_line_diagnostics<cr>", opts)
  buf_set_keymap("n", "gj", "<cmd>Lspsaga diagnostic_jump_next<cr>", opts)
  buf_set_keymap("n", "gk", "<cmd>Lspsaga diagnostic_jump_prev<cr>", opts)
  buf_set_keymap("n", "<C-u>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1, '<c-u>')<cr>", {})
  buf_set_keymap("n", "<C-d>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1, '<c-d>')<cr>", {})
  buf_set_keymap("n", "<space>sh", "<cmd>lua require('lspsaga.signature_help').signature_help()<cr>", opts)
  buf_set_keymap("n", "gr", "<cmd>lua require('lspsaga.provider').lsp_finder()<cr>", opts)
  -- buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  -- buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  -- buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  -- buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  -- buf_set_keymap('n', '<C-s>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  -- buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  -- buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  -- buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>bf', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

lsp_installer.on_server_ready(function(server)
  local opts = {}
  opts.on_attach = on_attach
  opts.capabilities = capabilities

  if server.name == "sumneko_lua" then
    opts.settings = {
      Lua = {
        format = { enable = true },
        diagnostics = {
          enable = true,
          globals = { 'vim' },
        },
        telemetry = { enable = false },
      },
    }
  end

  if server.name == "solargraph" then
    opts.settings = {
      solargraph = {
        autoformat = true,
        completion = true,
        diagnostics = true,
        folding = true,
        references = true,
        rename = true,
        symbols = true
      },
    }
  end

  server:setup(opts)
end)
