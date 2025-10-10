-- Setup Mason for installing LSP servers
local mason_status, mason = pcall(require, "mason")
if mason_status then
  mason.setup()
end

-- LSP keybindings on attach
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local bufnr = args.buf
    local bufopts = { noremap=true, silent=true, buffer=bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, bufopts)
  end,
})

-- Setup language servers using native vim.lsp.config
local capabilities = require('cmp_nvim_lsp').default_capabilities()

vim.lsp.config('lua_ls', {
  cmd = { 'lua-language-server' },
  root_markers = { '.luarc.json', '.luacheckrc', '.stylua.toml', 'stylua.toml', 'selene.toml', '.git' },
  capabilities = capabilities,
})

vim.lsp.config('gopls', {
  cmd = { 'gopls' },
  root_markers = { 'go.mod', 'go.work', '.git' },
  capabilities = capabilities,
})

vim.lsp.config('rust_analyzer', {
  cmd = { 'rust-analyzer' },
  root_markers = { 'Cargo.toml', '.git' },
  capabilities = capabilities,
})

vim.lsp.config('pyright', {
  cmd = { 'pyright-langserver', '--stdio' },
  root_markers = { 'pyproject.toml', 'setup.py', '.git' },
  capabilities = capabilities,
})

vim.lsp.config('bashls', {
  cmd = { 'bash-language-server', 'start' },
  root_markers = { '.git' },
  capabilities = capabilities,
})

-- Enable LSP servers
vim.lsp.enable({ 'lua_ls', 'gopls', 'rust_analyzer', 'pyright', 'bashls' })
