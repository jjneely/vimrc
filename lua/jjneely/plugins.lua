-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Plugin specifications
local plugins = {
  -- Core dependencies
  "nvim-lua/popup.nvim",
  "nvim-lua/plenary.nvim",

  -- Colorschemes
  "lunarvim/darkplus.nvim",
  "RRethy/nvim-base16",

  -- Completion plugins
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lsp",
      "saadparwaiz1/cmp_luasnip",
    },
  },
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-cmdline",
  "hrsh7th/cmp-nvim-lsp",
  "saadparwaiz1/cmp_luasnip",

  -- Snippets
  {
    "L3MON4D3/LuaSnip",
    build = "gmake install_jsregexp",
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
  },
  "rafamadriz/friendly-snippets",

  -- LSP
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    config = function()
      require("mason").setup()
    end,
  },

  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
  },

  -- Which-key for keybinding hints
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
  },

  -- Commented out plugins (uncomment to enable)
  -- "windwp/nvim-autopairs",
  -- "numToStr/Comment.nvim",
  -- "kyazdani42/nvim-web-devicons",
  -- "kyazdani42/nvim-tree.lua",
  -- "akinsho/bufferline.nvim",
  -- "moll/vim-bbye",
  -- "nvim-lualine/lualine.nvim",
  -- "akinsho/toggleterm.nvim",
  -- "ahmedkhalf/project.nvim",
  -- "lukas-reineke/indent-blankline.nvim",
  -- "goolord/alpha-nvim",
  -- "lewis6991/gitsigns.nvim",
  -- "JoosepAlviste/nvim-ts-context-commentstring",
}

-- Setup lazy.nvim
require("lazy").setup(plugins, {
  ui = {
    border = "rounded",
  },
  change_detection = {
    notify = false,
  },
})
