-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require('core.base')
require('core.mappings')

require("lazy").setup({
  spec = {
    { import = "plugins" },
  },
  -- FortiEDR/FortiClient authorize every exec on this machine; an unbounded
  -- burst of git spawns (Lazy's macOS default) saturates them, stalls every
  -- new process in _dyld_start, and cascades into system-wide EAGAIN.
  concurrency = 4,
  checker = { enabled = false },
  change_detection = { notify = false },
  rocks = { enabled = false },
})
