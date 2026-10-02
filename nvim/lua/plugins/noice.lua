return {
  {
    "folke/noice.nvim",
    lazy = false,
    dependencies = { "MunifTanjim/nui.nvim" },
    keys = {
      { "<Leader>x", "<cmd>Noice dismiss<CR>", desc = "Dismiss messages" },
    },
    config = function()
      require("noice").setup({
        -- Small corner text instead of popups; :Noice shows the history
        notify = { view = "mini" },
        messages = { view = "mini", view_warn = "mini", view_error = "mini" },
        lsp = {
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
          signature = {
            enabled = true,
          },
          hover = {
            enabled = true,
          },
          message = {
            view = "mini",
          },
        },
        -- you can enable a preset for easier configuration
        presets = {
          bottom_search = true, -- use a classic bottom cmdline for search
          command_palette = true, -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = false, -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = true, -- add a border to hover docs and signature help
        },
      })
    end
  }
}
