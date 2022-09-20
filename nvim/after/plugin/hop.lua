require('hop').setup({
  quit_key = '<SPC>'
})

vim.api.nvim_set_keymap('', '<Leader>w', "<cmd>lua require'hop'.hint_words({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR})<CR>", {})
vim.api.nvim_set_keymap('', '<Leader>b', "<cmd>lua require'hop'.hint_words({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR})<CR>", {})
vim.api.nvim_set_keymap('', '<Leader>l', "<cmd>lua require'hop'.hint_words({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true})<CR>", {})
