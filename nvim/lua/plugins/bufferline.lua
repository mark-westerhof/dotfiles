return {
  {
    'akinsho/bufferline.nvim',
    dependencies = {'nvim-tree/nvim-web-devicons'},
    config = function()
      require('bufferline').setup({
        options = {
          diagnostics = 'nvim_lsp',
          indicator = {
            style = 'none'
          },
          offsets = {
            {
              filetype = 'NvimTree',
              text = 'Files',
              separator = true
            }
          }
        }
      })
    end
  }
}
