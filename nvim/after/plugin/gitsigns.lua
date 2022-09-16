vim.opt.signcolumn = 'yes'

require('gitsigns').setup({
  current_line_blame = true,
  current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> <abbrev_sha>: <summary>'
})
