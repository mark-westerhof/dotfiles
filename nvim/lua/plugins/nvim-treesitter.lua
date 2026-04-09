return {
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSInstall bash css html javascript json lua markdown markdown_inline python typescript vim vimdoc yaml',
    config = function()
      require('nvim-treesitter').setup {
        install_dir = vim.fn.stdpath('data') .. '/site',
      }

      vim.api.nvim_create_autocmd('FileType', {
        callback = function(args)
          vim.treesitter.start(args.buf)
        end,
      })
    end,
  }
}
