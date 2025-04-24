return {
  'lewis6991/gitsigns.nvim',
  config = function()
    vim.opt.signcolumn = 'yes'

    require('gitsigns').setup({
      current_line_blame = true
    })
  end
}
