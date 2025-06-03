return {
  {
    'rcarriga/nvim-notify',
    config = function()
      local notify = require('notify')
      
      vim.notify = notify

      function dismiss_all_notifications()
        notify.dismiss()
      end

      vim.api.nvim_set_keymap('n', '<Leader>x', '<cmd>lua dismiss_all_notifications()<CR>', { noremap = true, silent = true })
    end
  }
}
