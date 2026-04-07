return {
  {
    'lukas-reineke/indent-blankline.nvim',
    main = "ibl",
    ---@module "ibl"
    ---@type ibl.config
    opts = {},
  },
  { 'tpope/vim-fugitive' },
  { 'kylechui/nvim-surround', opts = {} },
  {
    'aserowy/tmux.nvim',
    opts = {
      navigation = { enable_default_keybindings = false },
      resize = { enable_default_keybindings = false },
    }
  },
}
