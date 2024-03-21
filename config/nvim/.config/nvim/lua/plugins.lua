local fn = vim.fn


-----------------------------
-- Automatically install packer
--

local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if 0 < fn.empty(fn.glob(install_path)) then
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


-----------------------------
-- Configuration
--

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, 'packer')
if not status_ok then return end

-- Have packer use a popup window
packer.init({
  display = {
    open_fn = function()
      return require('packer.util').float({ border = 'rounded' })
    end,
  },
})


-----------------------------
-- On-save PackerSync
--

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])


-----------------------------
-- Install your plugins here
--

return packer.startup(function(use)
  use({ 'wbthomason/packer.nvim' }) -- package management
  use({ 'nvim-lua/plenary.nvim' })  -- Common utilities
  use({ 'nvim-lua/popup.nvim' })    -- Popup library

  use({
    'nvim-tree/nvim-web-devicons',
    config = function()
      require 'nvim-web-devicons'.setup {

        -- your personnal icons can go here (to override)
        -- you can specify color or cterm_color instead of specifying both of them
        -- DevIcon will be appended to `name`
        override = {
          zsh = {
            icon = "",
            color = "#428850",
            cterm_color = "65",
            name = "Zsh"
          }
        },

        -- globally enable different highlight colors per icon (default to true)
        -- if set to false all icons will have the default icon's color
        color_icons = true,

        -- globally enable default icons (default to false)
        -- will get overriden by `get_icons` option
        default = true,

        -- globally enable "strict" selection of icons - icon will be looked up in
        -- different tables, first by filename, and if not found by extension; this
        -- prevents cases when file doesn't have any extension but still gets some icon
        -- because its name happened to match some extension (default to false)
        strict = true,

        -- same as `override` but specifically for overrides by filename
        -- takes effect when `strict` is true
        override_by_filename = {
          [".gitignore"] = {
            icon = "",
            color = "#f1502f",
            name = "Gitignore"
          }
        },

        -- same as `override` but specifically for overrides by extension
        -- takes effect when `strict` is true
        override_by_extension = {
          ["log"] = {
            icon = "",
            color = "#81e043",
            name = "Log"
          }
        },
      }
    end
  })


  -----------------------------
  -- Theme
  --

  -- Colorscheme
  use {
    'catppuccin/nvim',
    as = 'catppuccin'
  }

  -- Transparent
  use {
    'xiyaowong/transparent.nvim',
    config = function()
      require("transparent").setup({
        -- table: default groups
        groups = {
          'Normal', 'NormalNC', 'Comment', 'Constant', 'Special', 'Identifier',
          'Statement', 'PreProc', 'Type', 'Underlined', 'Todo', 'String', 'Function',
          'Conditional', 'Repeat', 'Operator', 'Structure', 'LineNr', 'NonText',
          'SignColumn', 'CursorLineNr', 'EndOfBuffer',
        },

        -- table: additional groups that should be cleared
        extra_groups = {},

        -- table: groups you don't want to clear
        exclude_groups = {},
      })
    end
  }


  -----------------------------
  -- Colorizer
  --
  -- Colorize color codes in files.
  --

  use({
    'norcalli/nvim-colorizer.lua',
    config = function()
      local plugin = require('colorizer')
      plugin.setup()
    end
  })


  -----------------------------
  -- Status line
  --
  use({ 'nvim-lualine/lualine.nvim' })


  -----------------------------
  -- Completion
  --
  use({ 'neoclide/coc.nvim', branch = 'release' })

  -- Autopairs, integrates with both cmp and treesitter
  use({ 'windwp/nvim-autopairs' })

  -- Copilot
  use({ 'github/copilot.vim' })


  -----------------------------
  -- LSP
  --
  use({ 'neovim/nvim-lspconfig' }) -- config preset for each language server


  -----------------------------
  -- DAP
  --
  use({ 'mfussenegger/nvim-dap' })
  use({ 'rcarriga/nvim-dap-ui' })
  use({ 'https://github.com/mfussenegger/nvim-dap-python' })


  -----------------------------
  -- Filer, Grep
  --
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


  -----------------------------
  -- Highlight
  --

  -- Syntax highlight
  use({
    'nvim-treesitter/nvim-treesitter',
    config = function()
      require("nvim-treesitter.install").prefer_git = true
      local treesitter = require('nvim-treesitter.configs')
      treesitter.setup {
        ensure_installed = {
          "css",
          "fish",
          "html",
          "java",
          "javascript",
          "json",
          "lua",
          "python",
          "tsx",
          "typescript",
          "vim",
          "yaml"
        },

        highlight = {
          enable = true,
          disable = {},
        },

        indent = {
          enable = true,
        },

        autotag = {
          enable = true,
        }
      }
    end
  })

  -- Arguement highlight
  use { 'm-demare/hlargs.nvim',
    config = function()
      require('hlargs').setup()
    end
  }

  -- Indent highlight
  use {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      local hooks = require("ibl.hooks")
      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
        vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
        vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
        vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
        vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
        vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
        vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
      end)

      local highlight = {
        "RainbowRed",
        "RainbowYellow",
        "RainbowBlue",
        "RainbowOrange",
        "RainbowGreen",
        "RainbowViolet",
        "RainbowCyan",
      }

      require("ibl").setup(
      --   {
      --     indent = {
      --       highlight = highlight
      --     },
      --   }
      )
    end
  }


  -----------------------------
  -- Git
  --

  -- git
  use({
    'dinhhuy258/git.nvim',
    config = function()
      require("git").setup({
        -- NOTE: `quit_blame` and `blame_commit` are still merged to the keymaps even if `default_mappings = false`
        default_mappings = true,

        keymaps = {
          -- Open blame window
          blame = "<Leader>ao",

          -- Close blame window
          quit_blame = "q",

          -- Open blame commit
          blame_commit = "<CR>",

          -- Open file/folder in git repository
          browse = "<Leader>af",

          -- Open pull request of the current branch
          open_pull_request = "<Leader>ap",

          -- Create a pull request with the target branch is set in the `target_branch` option
          create_pull_request = "<Leader>an",

          -- Opens a new diff that compares against the current index
          diff = "<Leader>ad",

          -- Close git diff
          diff_close = "<Leader>ac",

          -- Revert to the specific commit
          revert = "<Leader>gr",

          -- Revert the current file to the specific commit
          revert_file = "<Leader>gR",
        },

        -- Default target branch when create a pull request
        target_branch = "main",
      })
    end
  })

  -- Git signs
  use({
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
    end
  })



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
  use 'brentyi/isort.vim'


  -----------------------------
  -- Scrollbar
  --

  use({
    "petertriho/nvim-scrollbar",
    config = function()
      require("scrollbar").setup()
    end
  })


  -----------------------------
  -- Code Comment
  --

  -- NerdCommenter
  use 'scrooloose/nerdcommenter'


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
  use {
    "SmiteshP/nvim-navic",
    requires = "neovim/nvim-lspconfig"
  }

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
      require("barbecue").navigate(2)
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
