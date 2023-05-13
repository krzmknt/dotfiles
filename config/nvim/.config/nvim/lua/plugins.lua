local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({
    'git',
    'clone',
    '--depth', '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path,
  })
  print('Installing packer close and reopen Neovim...')
  vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, 'packer')
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init({
  display = {
    open_fn = function()
      return require('packer.util').float({ border = 'rounded' })
    end,
  },
})

-- Install your plugins here
return packer.startup(function(use)
  -- general
  use({ 'wbthomason/packer.nvim' }) -- package management
  use({ 'nvim-lua/plenary.nvim' })  -- Common utilities
  use({ 'nvim-lua/popup.nvim' })

  -- Colorschemes
  use({ 'EdenEast/nightfox.nvim' })      -- Color scheme

  use({ 'nvim-lualine/lualine.nvim' })   -- Statusline
  use({ 'windwp/nvim-autopairs' })       -- Autopairs, integrates with both cmp and treesitter
  use({ 'nvim-tree/nvim-web-devicons' }) -- File icons
  use({ 'akinsho/bufferline.nvim' })

  -- cmp
  -- use({ 'hrsh7th/nvim-cmp' })         -- The completion plugin
  -- use({ 'hrsh7th/cmp-buffer' })       -- buffer completions
  -- use({ 'hrsh7th/cmp-path' })         -- path completions
  -- use({ 'hrsh7th/cmp-cmdline' })      -- cmdline completions
  -- use({ 'saadparwaiz1/cmp_luasnip' }) -- snippet completions
  -- use({ 'hrsh7th/cmp-nvim-lsp' })
  -- use({ 'hrsh7th/cmp-nvim-lua' })
  -- use({ 'onsails/lspkind-nvim' }) -- pictgram
  -- use({ 'hrsh7th/vim-vsnip' })
  -- use({ 'L3MON4D3/LuaSnip' })     --snippet engine

  use({ 'neoclide/coc.nvim', branch = 'release' })


  -- tag completion
  use({ 'windwp/nvim-ts-autotag' })

  -- LSP
  use({ 'neovim/nvim-lspconfig' })             -- config preset for each language server
  use({ 'williamboman/mason.nvim' })           -- installer for language server,  formatter and linter
  use({ 'williamboman/mason-lspconfig.nvim' }) --
  use({ 'jose-elias-alvarez/null-ls.nvim' })   -- for formatters and linters
  use({ 'glepnir/lspsaga.nvim' })              -- LSP UIs

  -- DAP
  use({ 'mfussenegger/nvim-dap' })
  use({ 'rcarriga/nvim-dap-ui' })
  use({ 'https://github.com/mfussenegger/nvim-dap-python' })

  -- Formatter
  use({ 'MunifTanjim/prettier.nvim' })

  -- Telescope
  use({ 'nvim-telescope/telescope.nvim' })
  use({
    'nvim-telescope/telescope-file-browser.nvim',
    requires = {
      'nvim-telescope/telescope.nvim',
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons', -- (optional)
      -- fd (optional)
      -- git (optional)
    }
  })


  -- Treesitter
  use({ 'nvim-treesitter/nvim-treesitter' })

  -- Color code highlights
  use({ 'norcalli/nvim-colorizer.lua' })

  -- git
  use({ 'lewis6991/gitsigns.nvim' })
  use({ 'dinhhuy258/git.nvim' })

  -- fine-cmdline
  use({
    'VonHeikemen/fine-cmdline.nvim',
    requires = {
      { 'MunifTanjim/nui.nvim' }
    }
  })

  -- Floatterm
  use({ 'voldikss/vim-floaterm' })

  -- Formatter
  use({ 'averms/black-nvim' })

  -- indent-blankline
  use "lukas-reineke/indent-blankline.nvim"

  -- ime
  use "brglng/vim-im-select"

  -- light filer
  use({ 'lambdalisue/fern.vim' })
  use({ 'lambdalisue/nerdfont.vim' })
  use({ 'lambdalisue/fern-renderer-nerdfont.vim' })
  vim.g['fern#renderer'] = 'nerdfont'

  -- transparent
  use({ 'xiyaowong/transparent.nvim' })


  -- copilot
  use({ 'github/copilot.vim' })


  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require('packer').sync()
  end
end)
