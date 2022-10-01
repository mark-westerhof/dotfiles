
require('onedark').setup {
  highlights = {
    TelescopeBorder = {fg = '$grey'},
    TelescopePromptBorder = {fg = '$grey'},
    TelescopeResultsBorder = {fg = '$grey'},
    TelescopePreviewBorder = {fg = '$grey'},
    DashboardHeader = {fg = '$light_grey'},
    DashboardCenter = {fg = '$light_grey'},
    DashboardShortCut = {fg = '$grey'}
  }
}

require('onedark').load()
vim.cmd('colorscheme onedark')
