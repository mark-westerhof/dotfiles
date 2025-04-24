
return {
  {
    'rcarriga/nvim-notify',
    config = function()
      local notify = require('notify')
      local lsp_notif = require('util.lsp-notification')

      vim.notify = notify

      function dismiss_all_notifications()
        lsp_notif.clear_notif_data()
        notify.dismiss()
      end

      vim.api.nvim_set_keymap('n', '<Leader>x', '<cmd>lua dismiss_all_notifications()<CR>', { noremap = true, silent = true })
    end
  }
}
