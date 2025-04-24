return {
  { 'gpanders/editorconfig.nvim' },
  {
    'lukas-reineke/indent-blankline.nvim',
    main = "ibl",
    ---@module "ibl"
    ---@type ibl.config
    opts = {},
  },
  { 'tpope/vim-fugitive' },
  {
    'terrortylor/nvim-comment',
    config = function()
      require('nvim_comment').setup()
    end
  },
  { 'kylechui/nvim-surround', opts = {} },
  { 'aserowy/tmux.nvim', options = {} }
}
