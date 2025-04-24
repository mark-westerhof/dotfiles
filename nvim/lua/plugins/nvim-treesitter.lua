return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function ()
      local configs = require("nvim-treesitter.configs")
      configs.setup({
        ensure_installed = {
          "bash",
          "c",
          "comment",
          "css",
          "html",
          "javascript",
          "jsdoc",
          "jsonc",
          "lua",
          "markdown",
          "markdown_inline",
          "query",
          "regex",
          "scss",
          "typescript",
          "vim",
          "vimdoc",
          "yaml",
        },
        sync_install = false,
        auto_install = true,
        highlight = { enable = true },
      })
    end
  }
}
