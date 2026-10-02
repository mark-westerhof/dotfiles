return {
  {
    'akinsho/bufferline.nvim',
    dependencies = {'nvim-tree/nvim-web-devicons'},
    config = function()
      local bufferline = require('bufferline')
      local accent = require('core.host').accent
      local muted = '#7f848e'
      -- Styled like tmux's window list: no fills, muted names, the current
      -- buffer bold in the host accent. The minimal preset paints every
      -- group with the Normal bg, so the highlights only set fg.
      bufferline.setup({
        options = {
          style_preset = {
            bufferline.style_preset.minimal,
            bufferline.style_preset.no_italic,
          },
          diagnostics = 'nvim_lsp',
          show_buffer_close_icons = false,
          show_close_icon = false,
          modified_icon = '●',
          separator_style = {'', ''},
          indicator = {
            style = 'none'
          },
          offsets = {
            {
              filetype = 'NvimTree',
              text = 'Files',
              separator = true
            }
          }
        },
        highlights = {
          background = { fg = muted },
          buffer_visible = { fg = muted },
          buffer_selected = { fg = accent, bold = true },
          modified = { fg = muted },
          modified_visible = { fg = muted },
          modified_selected = { fg = accent },
        }
      })
    end
  }
}
