return {
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    config = function()
      local ts = require('nvim-treesitter')
      ts.setup({ install_dir = vim.fn.stdpath('data') .. '/site' })

      -- Needs the tree-sitter CLI (installed by link_up). Without it, skip
      -- quietly and fall back to regex syntax instead of erroring every launch.
      if vim.fn.executable('tree-sitter') == 1 then
        -- Async; a no-op for parsers already installed. max_jobs keeps
        -- compiles from bursting processes under FortiEDR (see lazy.lua).
        ts.install({
          'angular', 'bash', 'css', 'html', 'javascript', 'json', 'python',
          'scss', 'tsx', 'typescript', 'yaml',
        }, { max_jobs = 2 })
      end

      vim.api.nvim_create_autocmd('FileType', {
        callback = function(args)
          local lang = vim.treesitter.language.get_lang(args.match)
          if lang and vim.treesitter.language.add(lang) then
            vim.treesitter.start(args.buf, lang)
          end
        end,
      })
    end,
  }
}
