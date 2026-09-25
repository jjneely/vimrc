-- nvim-treesitter, `main` branch.
--
-- The rewrite only installs parsers and ships query files. Turning features on
-- is Neovim's job now, so there is no `configs.setup` with a `highlight` table;
-- highlighting is started per buffer in the FileType autocommand below.

local ts = require "nvim-treesitter"

ts.setup {
  -- Parsers and queries land here, and it is prepended to 'runtimepath' so it
  -- wins over anything stale shipped inside the plugin directory.
  install_dir = vim.fn.stdpath "data" .. "/site",
}

-- Parsers to keep installed. markdown_inline and yaml are listed explicitly
-- because markdown injects both (fenced code and frontmatter) and a missing
-- parser there costs highlighting in the rest of the file.
ts.install {
  "bash",
  "go",
  "hcl",
  "javascript",
  "lua",
  "markdown",
  "markdown_inline",
  "python",
  "rust",
  "terraform",
  "typst",
  "yaml",
}

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("jjneely_treesitter", { clear = true }),
  desc = "Start treesitter highlighting when a parser is available",
  callback = function(args)
    local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
    if not lang or not vim.treesitter.language.add(lang) then
      return
    end
    vim.treesitter.start(args.buf, lang)
  end,
})
