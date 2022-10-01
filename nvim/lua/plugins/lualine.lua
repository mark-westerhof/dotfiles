require('lualine').setup{
   options = {
     theme = 'onedark',
     section_separators = '',
     component_separators = '',
     globalstatus = true,
     disabled_filetypes = { 'packer', 'dashboard', 'NvimTree' }
   }
}

vim.opt.cmdheight = 0
