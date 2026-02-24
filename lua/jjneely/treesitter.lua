require'nvim-treesitter.configs'.setup {
  ensure_installed = { "go", "rust", "lua", "python", "javascript", "bash", "typst" }, -- add languages you use
  highlight = {
    enable = true,
  },
}
