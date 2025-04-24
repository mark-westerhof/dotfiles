return {
  {
    'navarasu/onedark.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require('onedark').setup({
        highlights = {
          TelescopeBorder = {fg = '$grey'},
          TelescopePromptBorder = {fg = '$grey'},
          TelescopeResultsBorder = {fg = '$grey'},
          TelescopePreviewBorder = {fg = '$grey'},
          DashboardHeader = {fg = '$light_grey'},
          DashboardCenter = {fg = '$light_grey'},
          DashboardShortCut = {fg = '$grey'}
        }
      })
      require('onedark').load()
      vim.cmd('colorscheme onedark')

      -- https://github.com/yetone/avante.nvim/issues/1705
      vim.api.nvim_set_hl(0, "NormalFloat", { link = "Normal" })
    end
  }
}
