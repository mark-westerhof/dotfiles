--Remap leader
vim.g.mapleader = ','

-- Tabs -> 2 spaces
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- Turn on some features
vim.opt.number = true
vim.opt.spell = true

-- Turn off some features
vim.opt.wrap = false
vim.opt.hlsearch = false

-- Stay in the same column while navigating up/down
vim.opt.virtualedit = 'all'

-- Exit insert mode
vim.api.nvim_set_keymap('i', 'jk', '<Esc>', { noremap = true, silent = true })

-- Better split behaviour
vim.opt.splitbelow = true
vim.opt.splitright = true
