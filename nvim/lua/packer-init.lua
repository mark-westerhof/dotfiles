local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    print('Installing packer')
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)

  use 'wbthomason/packer.nvim'

  -- Syntax highlighting/formatting
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
  }
  use 'gpanders/editorconfig.nvim'

  -- Display plugins
  use 'navarasu/onedark.nvim'
  use {'nvim-lualine/lualine.nvim', requires = 'kyazdani42/nvim-web-devicons'}
  use {'akinsho/bufferline.nvim', tag = "v2.*", requires = 'kyazdani42/nvim-web-devicons'}
  use {'kyazdani42/nvim-tree.lua', requires = 'kyazdani42/nvim-web-devicons'}
  use {'lewis6991/gitsigns.nvim', tag = 'release'}
  use 'lukas-reineke/indent-blankline.nvim'
  use 'glepnir/dashboard-nvim'
  use 'rcarriga/nvim-notify'

  -- Searching
  use {'nvim-telescope/telescope.nvim', tag = '0.1.0', requires = 'nvim-lua/plenary.nvim'}
  use {'phaazon/hop.nvim', branch = 'v2'}
  use {'tpope/vim-fugitive'}

  -- QoL
  use 'alexghergh/nvim-tmux-navigation'
  use 'terrortylor/nvim-comment'
  use 'kylechui/nvim-surround'
  use 'roxma/vim-tmux-clipboard'
  use 'windwp/nvim-autopairs'

  -- LSP
  use 'neovim/nvim-lspconfig'
  use 'williamboman/mason.nvim'

  -- LSP & Completion
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'
  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'
  use 'rafamadriz/friendly-snippets'

  if packer_bootstrap then
    require('packer').sync()
  end

end)
