return {
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      { 'neovim/nvim-lspconfig' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'hrsh7th/cmp-cmdline' },
      { 'L3MON4D3/LuaSnip' },
      { 'saadparwaiz1/cmp_luasnip' }
    },
    config = function()
      vim.opt.completeopt = 'menu,menuone,noselect'

      local cmp = require('cmp')
      local luasnip = require('luasnip')

      local has_words_before = function()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      local cmp_kinds = {
        Text = '  ',
        Method = '  ',
        Function = '  ',
        Constructor = '  ',
        Field = '  ',
        Variable = '  ',
        Class = '  ',
        Interface = '  ',
        Module = '  ',
        Property = '  ',
        Unit = '  ',
        Value = '  ',
        Enum = '  ',
        Keyword = '  ',
        Snippet = '  ',
        Color = '  ',
        File = '  ',
        Reference = '  ',
        Folder = '  ',
        EnumMember = '  ',
        Constant = '  ',
        Struct = '  ',
        Event = '  ',
        Operator = '  ',
        TypeParameter = '  ',
      }

      cmp.setup({
        formatting = {
          format = function(_, vim_item)
            vim_item.kind = (cmp_kinds[vim_item.kind] or '') .. vim_item.kind
            return vim_item
          end,
        },
        snippet = {
          -- REQUIRED - you must specify a snippet engine
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
        window = {
          completion = {
            border = 'single',
            winhighlight = 'Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:Visual,Search:None',
          },
          documentation = {
            border = 'single',
            winhighlight = 'Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:Visual,Search:None',
          },
        },
        mapping = cmp.mapping.preset.insert({
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' }
        }, {
          { name = 'buffer' },
        })
      })

      -- Set configuration for specific filetype.
      cmp.setup.filetype('gitcommit', {
        sources = cmp.config.sources({
          { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
        }, {
          { name = 'buffer' },
        })
      })

      -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline('/', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        }
      })

      -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' }
        }, {
          { name = 'cmdline' }
        })
      })

      local signs = { Error = "󰅚 ", Warning = " ", Hint = "󰌶 ", Information = " " }
      vim.diagnostic.config({
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = signs.Error,
            [vim.diagnostic.severity.WARN]  = signs.Warning,
            [vim.diagnostic.severity.HINT]  = signs.Hint,
            [vim.diagnostic.severity.INFO]  = signs.Information,
          },
        },
      })

      local opts = { noremap = true, silent = true }
      vim.keymap.set('n', '[g', vim.diagnostic.goto_prev, opts)
      vim.keymap.set('n', ']g', vim.diagnostic.goto_next, opts)
      vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)

      vim.api.nvim_set_keymap('n', '<Leader>fl', ':LspEslintFixAll<CR>', opts)
      vim.api.nvim_set_keymap('n', '<Leader>rlsp', ':LspRestart<CR>', opts)

      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client and client:supports_method('textDocument/documentColor') then
            vim.lsp.document_color.enable(true, args.buf)
          end
        end,
      })

      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local servers = {
        'vtsls',
        'eslint',
        'cssls',
        'html'
      }

      for _, lsp in ipairs(servers) do
        vim.lsp.config(lsp, {
          flags = {
            debounce_text_changes = 150,
          },
          capabilities = capabilities
        })
        vim.lsp.enable(lsp)
      end

      local function find_angular_project_root()
        local current_dir = vim.fn.expand('%:p:h') -- Start from current file's directory
        local git_root = vim.fn.systemlist('git rev-parse --show-toplevel')[1]

        if vim.v.shell_error ~= 0 then
          git_root = vim.fn.getcwd() -- Fallback to cwd if not in git repo
        end

        while current_dir and current_dir ~= '/' and current_dir:find(git_root, 1, true) == 1 do
          local node_modules = current_dir .. '/node_modules'
          local angular_core = node_modules .. '/@angular/core'

          if vim.fn.isdirectory(node_modules) == 1 and vim.fn.isdirectory(angular_core) == 1 then
            return current_dir
          end

          current_dir = vim.fn.fnamemodify(current_dir, ':h')
        end

        return nil
      end

      local function get_angular_core_version(root_dir)
        local package_json = root_dir .. '/package.json'
        if not vim.uv.fs_stat(package_json) then
          return ''
        end

        local ok, content = pcall(vim.fn.readfile, package_json)
        if not ok or not content then
          return ''
        end

        local json_str = table.concat(content, '\n')
        local json = vim.json.decode(json_str) or {}

        local version = (json.dependencies or {})['@angular/core'] or ''
        return version:match('%d+%.%d+%.%d+') or ''
      end

      vim.lsp.config('angularls', {
        flags = {
          debounce_text_changes = 150,
        },
        capabilities = capabilities,
        root_dir = function(bufnr, on_dir)
          local angular_root = find_angular_project_root()
          if angular_root then
            on_dir(angular_root)
          end
        end,
        cmd = function(dispatchers, config)
          local root_dir = (config and config.root_dir) or vim.fn.getcwd()
          local node_modules = config.root_dir .. '/node_modules'
          local angular_version = get_angular_core_version(root_dir)
          local ts_probe = node_modules
          local ng_probe = node_modules .. '/@angular/language-server/node_modules'

          local cmd = {
            "ngserver",
            "--stdio",
            "--tsProbeLocations", ts_probe,
            "--ngProbeLocations", ng_probe
          }

          if angular_version ~= '' then
            table.insert(cmd, "--angularCoreVersion")
            table.insert(cmd, angular_version)
          end

          -- cwd is important so that volta can use the local ngserver
          return vim.lsp.rpc.start(cmd, dispatchers, { cwd = root_dir })
        end
      })

      vim.lsp.enable('angularls')

      require('luasnip.loaders.from_vscode').lazy_load()

      -- Debugging
      -- vim.lsp.set_log_level("debug")

    end
  }
}
