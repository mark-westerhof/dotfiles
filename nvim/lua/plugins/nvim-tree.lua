vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

local tree = require('nvim-tree')

tree.setup({
  update_focused_file = {
    enable = true
  }
})

local treeInitialized = false
local openForFiletypes = require('common-filetypes')

local function hasValue (tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false
end

vim.api.nvim_create_autocmd({'BufEnter', 'BufWinEnter'}, {
  callback = function()
    local ft = vim.bo.filetype
    if not treeInitialized and hasValue(openForFiletypes, ft) then
      tree.toggle(true, true)
      treeInitialized = true
    end
  end
})

vim.api.nvim_set_keymap('n', '<Leader>t', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
