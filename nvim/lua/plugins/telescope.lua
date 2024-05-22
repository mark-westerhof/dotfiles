local telescope = require('telescope')
local builtin = require('telescope.builtin')
local actions = require 'telescope.actions'
local lga_actions = require('telescope-live-grep-args.actions')

require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false
      }
    },
    sorting_strategy = 'ascending',
    layout_strategy = 'vertical',
    layout_config = {
      mirror = true,
      height = 0.95,
      prompt_position = 'top',
      preview_height = 0.4
    },
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "--trim"
    }
  },
  extensions = {
    live_grep_args = {
      auto_quoting = true,
      mappings = {
        i = {
          ['<C-k>'] = lga_actions.quote_prompt(),
          ['<C-i>'] = lga_actions.quote_prompt({ postfix = ' --iglob ' }),
          ['<C-space>'] = actions.to_fuzzy_refine,
        },
      },
    }
  }
}

telescope.load_extension('fzf')
telescope.load_extension('live_grep_args')

local function get_visual_selection()
  vim.cmd('noau normal! "vy"')
  local text = vim.fn.getreg('v')
  vim.fn.setreg('v', {})

  text = string.gsub(text, "\n", "")
  if #text > 0 then
    return text
  else
    return ''
  end
end

local function getCurrentFolderPath()
  return vim.fn.expand("%:p:h")
end

vim.keymap.set('n', '<Space>p', builtin.find_files, {})
vim.keymap.set('n', '<Space>d', function()
  builtin.find_files(
  {
    search_dirs = { getCurrentFolderPath() }
  }
  )
end)
vim.keymap.set('n', '<Space>g', function()
  telescope.extensions.live_grep_args.live_grep_args()
end)
vim.keymap.set('v', '<C-g>', function() 
  telescope.extensions.live_grep_args.live_grep_args({
    default_text = get_visual_selection()
  })
end)
vim.keymap.set('n', '<Space>b', builtin.buffers, {})
