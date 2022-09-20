require('lualine').setup{
   options = {
     theme = 'onedark',
     section_separators = { left = '', right = '' },
     component_separators = { left = '', right = '' },
     globalstatus = true,
     disabled_filetypes = { 'packer', 'dashboard', 'NvimTree' }
   }
}

vim.opt.showcmd = false
vim.opt.showmode = false
vim.opt.ruler = false
