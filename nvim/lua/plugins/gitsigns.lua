return {
  'lewis6991/gitsigns.nvim',
  config = function()
    vim.opt.signcolumn = 'yes'

    -- On this machine (FortiEDR/FortiClient endpoint security), a libuv
    -- fs_event watch on `.git/HEAD` self-oscillates: the security agent
    -- touches file metadata whenever the file is opened, and any watcher
    -- that re-arms by re-opening the file on each event (gitsigns'
    -- cwd-head watcher does exactly that, gitsigns.lua setup_cwd_watcher)
    -- loops at ~350 events/sec, spawning a `git rev-parse` per event until
    -- the per-user process limit is hit and everything gets EAGAIN.
    -- Upstream has no off switch for that watcher, so refuse fs_event
    -- watches on HEAD files at the luv level. Cost: vim.g.gitsigns_head
    -- only refreshes on startup and DirChanged, not live branch switches.
    if not vim.g.fs_event_head_guard then
      vim.g.fs_event_head_guard = true
      local uv = vim.uv or vim.loop
      local probe = assert(uv.new_fs_event())
      local fs_event_methods = getmetatable(probe).__index
      probe:close()
      local orig_start = fs_event_methods.start
      fs_event_methods.start = function(self, path, opts, cb)
        if type(path) == 'string' and path:match('%.git[/\\].-HEAD$') then
          return 0 -- pretend the watch was armed
        end
        return orig_start(self, path, opts, cb)
      end
    end

    require('gitsigns').setup({
      current_line_blame = true,
      -- Same failure mode as above via the per-buffer gitdir watcher; keep
      -- it off. Signs still refresh on buffer read/write.
      watch_gitdir = { enable = false },
    })
  end
}
