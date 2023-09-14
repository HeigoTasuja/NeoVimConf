local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  -- My plugins here

  -- Mason
  use {
	  "williamboman/mason.nvim",
	  run = ":MasonUpdate" --updates registry
  }

  -- Telescope
  use {
  'nvim-telescope/telescope.nvim', tag = '0.1.0',
  -- or, branch = '0.1.x',
  requires = { {'nvim-lua/plenary.nvim'} }
  }

  --Colors
  use({ 'ellisonleao/gruvbox.nvim' })
  use({ 'nanotech/jellybeans.vim' })

  --Treesitter
  use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate'})

  --Alpha-nvim
  use {
    'goolord/alpha-nvim',
    requires = { 'nvim-tree/nvim-web-devicons' },
    config = function ()
        require'alpha'.setup(require'alpha.themes.startify'.config)
    end
  }

  --LSP
  use {
      'VonHeikemen/lsp-zero.nvim',
      branch = 'v1.x',
	  requires = {

		  --Support
		  {'neovim/nvim-lspconfig'},
		  {'williamboman/mason.nvim'},
		  {'williamboman/mason-lspconfig.nvim'},

		  -- Autocompletion
		  {'hrsh7th/nvim-cmp'},
		  {'hrsh7th/cmp-buffer'},
		  {'hrsh7th/cmp-path'},
		  {'saadparwaiz1/cmp_luasnip'},
		  {'hrsh7th/cmp-nvim-lsp'},
		  {'hrsh7th/cmp-nvim-lua'},

		  -- Snippets
		  {'L3MON4D3/LuaSnip'},
		  {'rafamadriz/friendly-snippets'},
	  }
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
