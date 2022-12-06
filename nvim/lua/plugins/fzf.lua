local actions = require('fzf-lua.actions')

require('fzf-lua').setup{
  actions = {
    files = {
      ['default'] = actions.file_edit_or_qf,
      ['ctrl-o'] = actions.file_edit
    }
  },
  winopts = {
    hl = { border = 'LineNR', }
  },
  fzf_colors = {
    ['fg'] = { 'fg', 'Normal' },
    ['fg+'] = { 'fg', 'CursorLine' },
    ['hl'] = { 'fg', 'Comment' },
    ['hl+'] = { 'fg', 'Conditional' },
    ['bg'] = { 'bg', 'Normal' },
    ['bg+'] = { 'bg', 'CursorLine' },
    ['info'] = { 'fg', 'IncSearch' },
    ['prompt'] = { 'fg', 'Conditional' },
    ['pointer'] = { 'fg', 'Conditional' },
    ['marker'] = { 'fg', 'Conditional' },
    ['spinner'] = { 'fg', 'Label' },
    ['header'] = { 'fg', 'Comment' },
    ['gutter'] = { 'bg', 'Normal' },
  }
}

vim.api.nvim_set_keymap('n', '<Space>p', ':lua require("fzf-lua").files()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Space>d', ':lua require("fzf-lua").files({ cwd = vim.fn.expand("%:p:h") })<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<space>g', ':lua require("fzf-lua").live_grep({ cmd = "git grep --line-number --column --color=always" })<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<C-g>', '"hy:lua require("fzf-lua").live_grep({ cmd = "git grep --line-number --column --color=always", search = vim.fn.getreg("h") })<CR>', { noremap = true, silent = true })
