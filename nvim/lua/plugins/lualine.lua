return {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      options = {
        theme = 'onedark',
        section_separators = '',
        component_separators = '',
        globalstatus = true,
        disabled_filetypes = { 'packer', 'TelescopePrompt', 'NvimTree' }
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
  }
}
