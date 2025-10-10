require'nvim-treesitter.configs'.setup {
  ensure_installed = { "go", "rust", "lua", "python", "javascript", "bash" }, -- add languages you use
  highlight = {
    enable = true,
  },
}
