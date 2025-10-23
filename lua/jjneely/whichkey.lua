local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end

-- Configuration
which_key.setup({
  plugins = {
    marks = true, -- shows a list of your marks on ' and `
    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    spelling = {
      enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20, -- how many suggestions should be shown in the list?
    },
    presets = {
      operators = true, -- adds help for operators like d, y, c
      motions = true, -- adds help for motions
      text_objects = true, -- help for text objects triggered after entering an operator
      windows = true, -- default bindings on <c-w>
      nav = true, -- misc bindings to work with windows
      z = true, -- bindings for folds, spelling and others prefixed with z
      g = true, -- bindings for prefixed with g
    },
  },
  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "➜", -- symbol used between a key and its label
    group = "+", -- symbol prepended to a group
  },
  win = {
    border = "rounded", -- none, single, double, shadow, rounded
  },
})

-- Key mappings with descriptions
local opts = {
  mode = "n", -- NORMAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
  ["e"] = { ":Lex 30<cr>", "Explorer" },

  f = {
    name = "Find (Telescope)",
    f = { "<cmd>Telescope find_files<cr>", "Find Files" },
    g = { "<cmd>Telescope live_grep<cr>", "Live Grep" },
    b = { "<cmd>Telescope buffers<cr>", "Buffers" },
    h = { "<cmd>Telescope help_tags<cr>", "Help Tags" },
  },

  -- LSP mappings (these will be available when LSP is attached)
  D = { vim.lsp.buf.type_definition, "Type Definition" },
  r = {
    name = "Refactor",
    n = { vim.lsp.buf.rename, "Rename" },
  },
  c = {
    name = "Code",
    a = { vim.lsp.buf.code_action, "Code Action" },
  },
}

which_key.add({
  { "<leader>e", ":Lex 30<cr>", desc = "Explorer" },
  { "<leader>f", group = "Find (Telescope)" },
  { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
  { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
  { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
  { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help Tags" },
  { "<leader>D", vim.lsp.buf.type_definition, desc = "Type Definition" },
  { "<leader>r", group = "Refactor" },
  { "<leader>rn", vim.lsp.buf.rename, desc = "Rename" },
  { "<leader>c", group = "Code" },
  { "<leader>ca", vim.lsp.buf.code_action, desc = "Code Action" },
})

-- Register F-key descriptions (not prefix-based)
which_key.add({
  { "<F2>", desc = "Toggle Paste Mode" },
  { "<F3>", desc = "Trim Trailing Whitespace" },
  { "<F4>", desc = "Clear Search Highlight" },
  { "<F5>", desc = "Open Terminal" },
  { "<F6>", desc = "Trim Whitespace" },
})

-- Additional non-leader keybindings
which_key.add({
  { "gp", desc = "Reselect Pasted Text" },
  { "gD", vim.lsp.buf.declaration, desc = "Go to Declaration" },
  { "gd", vim.lsp.buf.definition, desc = "Go to Definition" },
  { "gi", vim.lsp.buf.implementation, desc = "Go to Implementation" },
  { "gr", vim.lsp.buf.references, desc = "References" },
  { "K", vim.lsp.buf.hover, desc = "Hover Documentation" },
})
