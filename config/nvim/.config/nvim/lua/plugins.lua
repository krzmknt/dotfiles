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
  use({ 'kepano/flexoki-neovim', as = 'flexoki' })
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
  -- use {
  --   'catppuccin/nvim',
  --   as = 'catppuccin'
  -- }

  -- Transparent
  -- use {
  --   'xiyaowong/transparent.nvim',
  --   config = function()
  --     require("transparent").setup({
  --       -- table: default groups
  --       groups = {
  --         'Normal', 'NormalNC', 'Comment', 'Constant', 'Special', 'Identifier',
  --         'Statement', 'PreProc', 'Type', 'Underlined', 'Todo', 'String', 'Function',
  --         'Conditional', 'Repeat', 'Operator', 'Structure', 'LineNr', 'NonText',
  --         'SignColumn', 'CursorLineNr', 'EndOfBuffer',
  --       },

  --       -- table: additional groups that should be cleared
  --       extra_groups = {},

  --       -- table: groups you don't want to clear
  --       exclude_groups = {},
  --     })
  --   end
  -- }

  -- https://github.com/navarasu/onedark.nvim
  use 'navarasu/onedark.nvim'

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
      'delphinus/telescope-memo.nvim',
      -- https://github.com/mattn/memo
    },
    config = function()
      require 'telescope'.load_extension 'memo'
    end,
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
      -- local hooks = require("ibl.hooks")
      -- hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
      --   vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75", blend = 30 })
      --   vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B", blend = 30 })
      --   vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF", blend = 30 })
      --   vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66", blend = 30 })
      --   vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379", blend = 30 })
      --   vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD", blend = 30 })
      --   vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2", blend = 30 })
      -- end)

      -- local highlight = {
      --   "RainbowRed",
      --   "RainbowYellow",
      --   "RainbowBlue",
      --   "RainbowOrange",
      --   "RainbowGreen",
      --   "RainbowViolet",
      --   "RainbowCyan",
      -- }

      -- require("ibl").setup(
      -- --   {
      -- --     indent = {
      -- --       highlight,
      -- --     },
      -- --   }
      -- )

      require("ibl").setup {
        indent = {
          char = "│", -- Center alighned solid (see. :h ibl.config.indent)
          -- highlight = {
          --   "RainbowRed", "RainbowYellow", "RainbowBlue",
          --   "RainbowOrange", "RainbowGreen", "RainbowViolet", "RainbowCyan"
          -- },
        },
        scope = { enabled = true, show_start = true, show_end = true },
      }
    end
  }


  -----------------------------
  -- Git
  --

  use({
    'tpope/vim-fugitive',
    config = function()
      vim.cmd([[
        nnoremap <leader>gs :Git status<CR>
        nnoremap <leader>gd :Gdiff<CR>
        nnoremap <leader>gb :Git blame<CR>
        nnoremap <leader>gl :Git log --graph<CR>
      ]])
    end
  })

  use({
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup {
        signs                        = {
          add          = { text = '│' },
          change       = { text = '│' },
          delete       = { text = '_' },
          topdelete    = { text = '‾' },
          changedelete = { text = '~' },
          untracked    = { text = '┆' },
        },

        signcolumn                   = false, -- Toggle with `:Gitsigns toggle_signs`
        numhl                        = true,  -- Toggle with `:Gitsigns toggle_numhl`
        linehl                       = true,  -- Toggle with `:Gitsigns toggle_linehl`
        word_diff                    = true,  -- Toggle with `:Gitsigns toggle_word_diff`
        watch_gitdir                 = {
          follow_files = true
        },

        auto_attach                  = true,
        attach_to_untracked          = true,
        current_line_blame           = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
        current_line_blame_opts      = {
          virt_text = true,
          virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
          delay = 00,
          ignore_whitespace = false,
          virt_text_priority = 100,
        },

        current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
        sign_priority                = 100,
        update_debounce              = 100,
        status_formatter             = nil,   -- Use default
        max_file_length              = 40000, -- Disable if file is longer than this (in lines)
        preview_config               = {
          -- Options passed to nvim_open_win
          border = 'single',
          style = 'minimal',
          relative = 'cursor',
          row = 0,
          col = 1
        }

      }
      require("scrollbar.handlers.gitsigns").setup()
    end
  })

  -- diffview
  use({ "sindrets/diffview.nvim" })


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


  -----------------------------
  -- Memo
  --
  -- https://zenn.dev/koga1020/articles/009766e1bec42c
  --
  use 'glidenote/memolist.vim'


  -----------------------------
  -- Mardown preview
  --
  -- https://github.com/iamcco/markdown-preview.nvim
  --
  -- install without yarn or npm
  use({
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
  })

  -- use({
  --   'MeanderingProgrammer/render-markdown.nvim',
  --   after = { 'nvim-treesitter' },
  --   requires = { 'echasnovski/mini.nvim', opt = true }, -- if you use the mini.nvim suite
  --   -- requires = { 'echasnovski/mini.icons', opt = true }, -- if you use standalone mini plugins
  --   -- requires = { 'nvim-tree/nvim-web-devicons', opt = true }, -- if you prefer nvim-web-devicons
  --   config = function()
  --     require('render-markdown').setup({})
  --   end,
  -- })

  -----------------------------
  -- Noice
  --
  use({ "MunifTanjim/nui.nvim" })
  use({ "rcarriga/nvim-notify" })
  use({
    "folke/noice.nvim",
    opts = {
      -- add any options here
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    }
  })



  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require('packer').sync()
  end
end)
