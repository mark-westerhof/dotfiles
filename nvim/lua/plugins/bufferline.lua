require('bufferline').setup{
  options = {
    diagnostics = 'nvim_lsp',
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
vim.cmd([[highlight! link BufferLineOffsetSeparator LineNr]])
