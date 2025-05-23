local skip = true
if skip then return {} end


-----------------------------
-- Install your plugins here
--

return packer.startup(function(use)
  use({ 'kepano/flexoki-neovim', as = 'flexoki' })
  use({ 'wbthomason/packer.nvim' }) -- package management
  use({ 'nvim-lua/plenary.nvim' })  -- Common utilities
  use({ 'nvim-lua/popup.nvim' })    -- Popup library




  -----------------------------
  -- LSP
  --
  use() -- config preset for each language server
  --  use({ "williamboman/mason.nvim" })
  --  use({ "williamboman/mason-lspconfig.nvim" })
  --  use({ 'nvimtools/none-ls.nvim' })
  --  use({ 'jay-babu/mason-null-ls.nvim' })


  -----------------------------
  -- DAP
  --
  use({ 'mfussenegger/nvim-dap' })
  use({ 'rcarriga/nvim-dap-ui' })
  use({ 'https://github.com/mfussenegger/nvim-dap-python' })





  -----------------------------
  -- Floating window
  --

  -- Floatterm
  use({ 'voldikss/vim-floaterm' })


  -----------------------------
  -- Linter, Formatter
  --

  use({ 'MunifTanjim/prettier.nvim' })
  use({ 'averms/black-nvim' })
  use({ 'brentyi/isort.vim' })


  -----------------------------
  -- Scrollbar
  --

  use({
    "petertriho/nvim-scrollbar",
    config = function()
      require("scrollbar").setup({})
    end
  })


  -----------------------------
  -- Code Comment
  --

  -- NerdCommenter
  use({ 'scrooloose/nerdcommenter' })


  -----------------------------
  -- Command line
  --

  -- fine-cmdline
  use({
    'VonHeikemen/fine-cmdline.nvim',
    requires = {
      { 'MunifTanjim/nui.nvim' }
    }
  })


  -----------------------------
  -- Navigation
  --

  -- barbecue
  use({
    "SmiteshP/nvim-navic",
    requires = "neovim/nvim-lspconfig"
  })

  use({
    "utilyre/barbecue.nvim",
    tag = "*",
    requires = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons", -- optional dependency
    },
    after = "nvim-web-devicons",     -- keep this if you're using NvChad
    config = function()
      require("barbecue").setup()
      -- require("barbecue").navigate(2)
    end,
  })


  -----------------------------
  -- Buffer
  --

  -- Buffer line
  use({
    'akinsho/bufferline.nvim',
    tag = "*",
    requires = 'nvim-tree/nvim-web-devicons'
  })



  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require('packer').sync()
  end
end)
