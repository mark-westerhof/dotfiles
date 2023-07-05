require('lualine').setup{
  options = {
    theme = 'onedark',
    section_separators = '',
    component_separators = '',
    globalstatus = true,
    disabled_filetypes = { 'packer', 'fzf', 'NvimTree' }
  },
  sections = {
    lualine_b = {
      'diff',
      'diagnostics'
    },
    lualine_c = {
      {
        'filename',
        path = 1
      }
    }
  }
}

vim.opt.cmdheight = 0
