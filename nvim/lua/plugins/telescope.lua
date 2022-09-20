require('telescope').setup({
  defaults = {
    mappings = {
      i = {
        ['<C-j>'] = 'move_selection_next',
        ['<C-k>'] = 'move_selection_previous'
      }
    },
    path_display = {
      truncate = 1
    }
  }
})
vim.api.nvim_set_keymap('n', '<Space>p', '<cmd>Telescope find_files<CR>', { noremap = true, silent = true })
