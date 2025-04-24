
return {
  'nvim-tree/nvim-tree.lua',
  dependencies = {
    'nvim-tree/nvim-web-devicons'
  },
  config = function()
    local tree = require('nvim-tree')
    local treeInitialized = false

    tree.setup({
      update_focused_file = {
        enable = true
      },
      view = {
        width = 40
      },
    })

    vim.api.nvim_set_keymap('n', '<Leader>t', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
  end,
}
