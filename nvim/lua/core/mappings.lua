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

-- Window shortcuts
vim.api.nvim_set_keymap('n', '<Leader>o', ':only<CR>', { noremap = true, silent = true })

-- Quickfix shortcuts
vim.api.nvim_set_keymap('n', ']q', ':cnext<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '[q', ':cprev<CR>', { noremap = true, silent = true })

-- Copy pasting between vim instances and remote clipboard
vim.api.nvim_set_keymap('v', '<Leader>y', ':w! /tmp/vim_clipboard<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('v', '<Leader>r', ':w! !ssh -p 6788 localhost pbcopy<CR><CMD>lua vim.notify("Text copied to remote clipboard")<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<Leader>p', ':r! cat /tmp/vim_clipboard<CR>', {noremap = true, silent = true})

-- Find and replace selected
vim.api.nvim_set_keymap('v', '<C-r>', '"hy:.,$s/<C-r>h//g<left><left>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('v', '<C-s>', '"hy:.,$s/<C-r>h//gc<left><left><left>', {noremap = true, silent = true})

-- Copy buffer filename to register
vim.api.nvim_set_keymap('n', '<Leader>cbf', ':let @+ = expand("%:p")<CR>', { noremap = true, silent = true })
