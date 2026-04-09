-- Wrap vim.treesitter.start so built-in ftplugins don't crash
-- when parsers aren't installed yet (e.g. fresh machine)
do
  local orig = vim.treesitter.start
  vim.treesitter.start = function(...)
    pcall(orig, ...)
  end
end

require('config.lazy')
