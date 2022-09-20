require('bufferline').setup{
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
}

-- Customizations
vim.cmd([[highlight! link BufferLineOffsetSeparator NvimTreeVertSplit]])
