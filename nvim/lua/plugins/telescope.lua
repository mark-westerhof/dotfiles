require('telescope').setup({
  defaults = {
    mappings = {
      i = {
        ['<C-j>'] = 'move_selection_next',
        ['<C-k>'] = 'move_selection_previous',
        ['<C-u>'] = false
      }
    },
    path_display = {
      truncate = 1
    }
  }
})

require('telescope').load_extension('fzf')

vim.api.nvim_set_keymap('n', '<Space>p', '<cmd>Telescope find_files<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Space>d', ':lua require("telescope.builtin").find_files( { cwd = vim.fn.expand("%:p:h") })<CR>',
  { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Space>g', '<cmd>Telescope live_grep<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Space>h', '<cmd>Telescope help_tags<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Space>/', '<cmd>Telescope current_buffer_fuzzy_find fuzzy=false case_mode=ignore_case<CR>', { noremap = true, silent = true })
