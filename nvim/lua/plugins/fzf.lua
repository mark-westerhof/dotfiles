local actions = require('fzf-lua.actions')

require('fzf-lua').setup{
  actions = {
    files = {
      ['default'] = actions.file_edit_or_qf,
      ['ctrl-o'] = actions.file_edit
    }
  },
  winopts = {
    hl = { border = 'LineNR', },
    height = 0.9,
    width = 0.9,
    preview = {
      layout = 'vertical'
    }
  },
  fzf_colors = {
    ['fg'] = { 'fg', 'Normal' },
    ['fg+'] = { 'fg', 'CursorLine' },
    ['hl'] = { 'fg', 'Comment' },
    ['hl+'] = { 'fg', 'Conditional' },
    ['bg'] = { 'bg', 'Normal' },
    ['bg+'] = { 'bg', 'Normal' },
    ['info'] = { 'fg', 'Normal' },
    ['prompt'] = { 'fg', 'Normal' },
    ['pointer'] = { 'fg', 'Conditional' },
    ['marker'] = { 'fg', 'Conditional' },
    ['spinner'] = { 'fg', 'Conditional' },
    ['header'] = { 'fg', 'Normal' },
    ['gutter'] = { 'bg', 'Normal' },
  }
}

vim.api.nvim_set_keymap('n', '<Space>p', ':lua require("fzf-lua").files({ fzf_opts = {["--keep-right"] = ""} })<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Space>d', ':lua require("fzf-lua").files({ cwd = vim.fn.expand("%:p:h"), fzf_opts = {["--keep-right"] = ""} })<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<space>g', ':lua require("fzf-lua").live_grep({ cmd = "git grep --line-number --column --color=always" })<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<C-g>', '"hy:lua require("fzf-lua").live_grep({ cmd = "git grep --line-number --column --color=always", search = vim.fn.getreg("h") })<CR>', { noremap = true, silent = true })
