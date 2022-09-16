vim.opt.termguicolors = true

require('base16-colorscheme').with_config {
    telescope = false,
}

vim.cmd("colorscheme base16-onedark")

-- Customizations
vim.cmd([[highlight! link VertSplit LineNr]])
