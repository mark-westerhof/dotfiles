-- Window navigation
vim.api.nvim_set_keymap('n', '<C-h>', ':wincmd h<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-j>', ':wincmd j<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-k>', ':wincmd k<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-l>', ':wincmd l<CR>', { noremap = true, silent = true })

-- Buffer navigation
vim.api.nvim_set_keymap('n', 'fg', ':bf<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'fj', ':bn<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'fk', ':bp<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'fl', ':bl<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'fd', ':bp<bar>sp<bar>bn<bar>bd<CR>', { noremap = true, silent = true })

--Window shortcuts
vim.api.nvim_set_keymap('n', '<Leader>o', ':only<CR>', { noremap = true, silent = true })
