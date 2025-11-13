local logger = require("util.logger")

-----------------------------
-- Bootstrap lazy.nvim

local lazypath = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy", "lazy.nvim")
logger.debug("lazypath: " .. lazypath)

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })

  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end

  logger.info("Lazy has been successfully installed!")
end
vim.opt.rtp:prepend(lazypath)

-----------------------------
-- Setup

local pluginLoader = require("util.pluginLoader")
local lazy = pluginLoader.load({ pluginName = "lazy" })
if lazy == nil then return end

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("lazy").setup({
  spec = {
    -- import your plugins
    { import = "plugins" },

    --- カラーコードに背景色を付ける
    --- @see https://github.com/norcalli/nvim-colorizer.lua
    {
      'norcalli/nvim-colorizer.lua',
      config = function()
        local colorizer = require('colorizer')
        colorizer.setup()
      end
    },

    --- Tailwind CSS クラスに色を付ける
    --- @see https://github.com/luckasRanarison/tailwind-tools.nvim
    {
      'luckasRanarison/tailwind-tools.nvim',
      dependencies = { 'nvim-treesitter/nvim-treesitter' },
      build = ':UpdateRemotePlugins',
      opts = {}  -- Use default settings with native LSP
    },

    --- ステータスラインをカスタマイズ
    --- @see https://github.com/nvim-lualine/lualine.nvim
    {
      'nvim-lualine/lualine.nvim',
      dependencies = {
        'nvim-tree/nvim-web-devicons',
      }
    },

    --- <Leader>c<space> で選択したコメントブロックをコメントトグル
    --- @see https://github.com/preservim/nerdcommenter#default-mappings
    { 'scrooloose/nerdcommenter' },

    --- メッセージやコマンドラインの表示をリッチにする
    --- @see https://github.com/folke/noice.nvim
    -- {
    --   "folke/noice.nvim",
    --   event = "VeryLazy",
    --   dependencies = {
    --     "MunifTanjim/nui.nvim",
    --     { "rcarriga/nvim-notify", opts = { top_down = true, stages = "static" } },
    --   },
    -- },

    ------------------------------------
    -- Completion

    --- 閉じ括弧を自動で補完
    --- @see https://github.com/windwp/nvim-autopairs
    {
      'windwp/nvim-autopairs',
      event = "InsertEnter",
      config = true
      -- use opts = {} for passing setup options
      -- this is equivalent to setup({}) function
    },

    --- 定義の表示
    --- @see https://github.com/dnlhc/glance.nvim
    {
      'dnlhc/glance.nvim',
      cmd = 'Glance'
    },

    ------------------------------------
    -- AI

    --- GitHub Copilot によるコード補完
    --- @see https://github.com/github/copilot.vim
    { 'github/copilot.vim' },

    --- Copilot Chat
    --- @see https://github.com/CopilotC-Nvim/CopilotChat.nvim
    {
      'CopilotC-Nvim/CopilotChat.nvim',
      config = function()
        require("CopilotChat").setup {
          model = 'o3-mini',
          agent = 'copilot',
          window = {
            width = 0.8,
            height = 0.8,
            border = "rounded",
            highlight = "Normal",
            layout = "float",
          }
        }
      end
    },

    ------------------------------------
    -- Fazzy Finder

    --- Fazzy Finder
    --- @see https://github.com/nvim-telescope/telescope.nvim
    {
      'nvim-telescope/telescope.nvim',
      dependencies = { 'nvim-lua/plenary.nvim' }
    },

    --- Telescope のファイルブラウザ拡張機能
    --- @see https://github.com/nvim-telescope/telescope-file-browser.nvim
    {
      'nvim-telescope/telescope-file-browser.nvim',
      dependencies = {
        'nvim-telescope/telescope.nvim',
        'nvim-lua/plenary.nvim',
        'nvim-tree/nvim-web-devicons',
      },
    },

    -------------------------
    -- Highlight

    --- Highlight
    --- @see https://github.com/nvim-treesitter/nvim-treesitter
    {
      'nvim-treesitter/nvim-treesitter',
      config = function()
        require("nvim-treesitter.install").prefer_git = true
        local treesitter = require('nvim-treesitter.configs')
        treesitter.setup {
          auto_install = true,
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
    },

    --- 引数のハイライト
    --- @see https://github.com/m-demare/hlargs.nvim
    {
      'm-demare/hlargs.nvim',
      dependencies = { 'nvim-treesitter/nvim-treesitter' },
      config = function()
        require('hlargs').setup()
      end
    },

    --- インデントハイライト
    --- @see https://github.com/lukas-reineke/indent-blankline.nvim
    --- 廃止 2025-03-16
    -- {
    --   "lukas-reineke/indent-blankline.nvim",
    --   config = function()
    --     -- local hooks = require("ibl.hooks")
    --     -- hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    --     --   vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75", blend = 30 })
    --     --   vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B", blend = 30 })
    --     --   vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF", blend = 30 })
    --     --   vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66", blend = 30 })
    --     --   vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379", blend = 30 })
    --     --   vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD", blend = 30 })
    --     --   vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2", blend = 30 })
    --     -- end)

    --     -- local highlight = {
    --     --   "RainbowRed",
    --     --   "RainbowYellow",
    --     --   "RainbowBlue",
    --     --   "RainbowOrange",
    --     --   "RainbowGreen",
    --     --   "RainbowViolet",
    --     --   "RainbowCyan",
    --     -- }

    --     -- require("ibl").setup(
    --     -- --   {
    --     -- --     indent = {
    --     -- --       highlight,
    --     -- --     },
    --     -- --   }
    --     -- )

    --     require("ibl").setup {
    --       indent = {
    --         char = "│", -- Center alighned solid (see. :h ibl.config.indent)
    --         -- highlight = {
    --         --   "RainbowRed", "RainbowYellow", "RainbowBlue",
    --         --   "RainbowOrange", "RainbowGreen", "RainbowViolet", "RainbowCyan"
    --         -- },
    --       },
    --       scope = { enabled = true, show_start = true, show_end = true },
    --     }
    --   end
    -- },

    --- インデントハイライト
    --- @see https://github.com/shellRaining/hlchunk.nvim
    {
      "shellRaining/hlchunk.nvim",
      event = { "BufReadPre", "BufNewFile" },
      config = function()
        require("hlchunk").setup({
          chunk = {
            enable = true,
            priority = 15,
            style = {
              { fg = "#806d9c", },
              { fg = "#c21f30", },
            },
            use_treesitter = true,
            chars = {
              left_arrow = "─",
              horizontal_line = "─",
              vertical_line = "│",
              left_top = "╭",
              left_bottom = "╰",
              right_arrow = "─", -- ">",
            },
            textobject = "",
            max_file_size = 1024 * 1024,
            error_sign = true,
            duration = 100,
            delay = 0,
          },

          indent = {
            enable = true,
            -- style = { vim.api.nvim_get_hl(0, { name = "Whitespace" }) },
            style = {
              { fg = "#252525", },
            },
            priority = 10,
            use_treesitter = false,
            chars = { "│" },
            ahead_lines = 5,
            delay = 100,
            filter_list = {},
          }
        })
      end
    },

    --- 親スコープをヘッダー表示
    --- @see https://github.com/nvim-treesitter/nvim-treesitter-context
    {
      "nvim-treesitter/nvim-treesitter-context",
      config = function()
        require("treesitter-context").setup({
          enable = true,            -- Enable this plugin (Can be enabled/disabled later via commands)
          multiwindow = false,      -- Enable multiwindow support.
          max_lines = 0,            -- How many lines the window should span. Values <= 0 mean no limit.
          min_window_height = 0,    -- Minimum editor window height to enable context. Values <= 0 mean no limit.
          line_numbers = true,
          multiline_threshold = 20, -- Maximum number of lines to show for a single context
          trim_scope = 'outer',     -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
          mode = 'cursor',          -- Line used to calculate context. Choices: 'cursor', 'topline'
          -- Separator between context and content. Should be a single character string, like '-'.
          -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
          separator = nil,
          zindex = 20,     -- The Z-index of the context window
          on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
        })
      end
    },

    --- シンボルジャンプ
    --- @see https://github.com/bassamsdata/namu.nvim
    {
      "bassamsdata/namu.nvim",
      config = function()
        require("namu").setup({
          -- Enable the modules you want
          namu_symbols = {
            enable = true,
            options = {}, -- here you can configure namu
          },
          -- Optional: Enable other modules if needed
          ui_select = { enable = false }, -- vim.ui.select() wrapper
          colorscheme = {
            enable = false,
            options = {
              -- NOTE: if you activate persist, then please remove any vim.cmd("colorscheme ...") in your config, no needed anymore
              persist = true,      -- very efficient mechanism to Remember selected colorscheme
              write_shada = false, -- If you open multiple nvim instances, then probably you need to enable this
            },
          },
        })
        -- === Suggested Keymaps: ===
        vim.keymap.set("n", "<leader>ss", ":Namu symbols<cr>", {
          desc = "Jump to LSP symbol",
          silent = true,
        })
        vim.keymap.set("n", "<leader>th", ":Namu colorscheme<cr>", {
          desc = "Colorscheme Picker",
          silent = true,
        })
      end,
    },

    --- jk の加速度設定
    --- @see https://github.com/rainbowhxch/accelerated-jk.nvim
    {
      'rainbowhxch/accelerated-jk.nvim',
      config = function()
        require('accelerated-jk').setup({
          mode = 'time_driven',
          enable_deceleration = false,
          acceleration_motions = {},
          acceleration_limit = 150,

          -- line per second
          acceleration_table = { 7, 12, 17, 21, 24, 26, 28, 30 },

          -- when 'enable_deceleration = true', 'deceleration_table = { {200, 3}, {300, 7}, {450, 11}, {600, 15}, {750, 21}, {900, 9999} }'
          deceleration_table = { { 150, 9999 } }
        })
      end
    },


    -----------------------------
    -- Git

    --- @see https://github.com/tpope/vim-fugitive
    {
      'tpope/vim-fugitive',
      config = function()
        vim.cmd([[
          nnoremap <leader>gs :Git status<CR>
          nnoremap <leader>gd :Gdiff<CR>
          nnoremap <leader>gb :Git blame<CR>
          nnoremap <leader>gl :Git log --graph<CR>
        ]])
      end
    },

    --- @see https://github.com/lewis6991/gitsigns.nvim
    {
      'lewis6991/gitsigns.nvim',
      dependencies = { 'nvim-lua/plenary.nvim' },
      config = function()
        -- 優しくておしゃれな色設定
        vim.api.nvim_set_hl(0, 'GitSignsAddInline', { bg = '#2d4a3e', fg = '#a8ddb5' })
        vim.api.nvim_set_hl(0, 'GitSignsChangeInline', { bg = '#3d4057', fg = '#c8b8e8' })
        vim.api.nvim_set_hl(0, 'GitSignsDeleteInline', { bg = '#4a2d3e', fg = '#e8b8c8' })
        vim.api.nvim_set_hl(0, 'GitSignsAddLn', { bg = '#1a2e26' })
        vim.api.nvim_set_hl(0, 'GitSignsChangeLn', { bg = '#1f1e33' })
        vim.api.nvim_set_hl(0, 'GitSignsDeleteLn', { bg = '#2e1a26' })

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
    },

    -- Linter, formatter
    { 'MunifTanjim/prettier.nvim' },
    { 'averms/black-nvim' },
    { 'brentyi/isort.vim' },

    -- float term
    { 'voldikss/vim-floaterm' },

    -- dap
    -- { 'mfussenegger/nvim-dap' },
    -- { 'rcarriga/nvim-dap-ui' },
    -- { 'https://github.com/mfussenegger/nvim-dap-python' },

    --- Scroll bar
    --- @see https://github.com/petertriho/nvim-scrollbar
    {
      "petertriho/nvim-scrollbar",
      config = function()
        require("scrollbar").setup({})
      end
    },


    {
      'nvim-tree/nvim-tree.lua',
      requires = {
        'nvim-tree/nvim-web-devicons'
      },
      config = function()
        require("nvim-tree").setup({
          view = {
            width = 50,
            side = "left",
          },
          update_focused_file = {
            enable = true,
            update_root = false,
          },
          on_attach = function(bufnr)
            local api = require('nvim-tree.api')

            local function opts(desc)
              return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
            end

            -- Default mappings
            api.config.mappings.default_on_attach(bufnr)

            -- Remove default 'f' mapping
            vim.keymap.del('n', 'f', { buffer = bufnr })

            -- Add Ctrl+f for filter
            vim.keymap.set('n', '<C-f>', api.live_filter.start, opts('Start Live Filter'))

            -- Add left/right arrow keys for collapse/expand
            vim.keymap.set('n', '<Left>', api.node.navigate.parent_close, opts('Close Directory'))
            vim.keymap.set('n', '<Right>', api.node.open.edit, opts('Open Directory'))
          end
        })
      end
    },

    { "sindrets/diffview.nvim" },

    -- Colorscheme
    { 'navarasu/onedark.nvim' },

    -- Command line
    {
      'VonHeikemen/fine-cmdline.nvim',
      requires = {
        { 'MunifTanjim/nui.nvim' }
      }
    },

    --- パンくずリスト
    --- @see https://github.com/utilyre/barbecue.nvim
    --- 廃止 2025-03-16
    -- Navigation
    -- {
    --   "utilyre/barbecue.nvim",
    --   name = "barbecue",
    --   version = "*",
    --   dependencies = {
    --     "SmiteshP/nvim-navic",
    --     "nvim-tree/nvim-web-devicons",
    --   },
    --   opts = {},
    -- },


    --- パンくずリスト
    --- @see https://github.com/Bekaboo/dropbar.nvim
    {
      'Bekaboo/dropbar.nvim',
      -- optional, but required for fuzzy finder support
      dependencies = {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make'
      },
      config = function()
        local dropbar_api = require('dropbar.api')
        vim.keymap.set('n', '<Leader>;', dropbar_api.pick, { desc = 'Pick symbols in winbar' })
        vim.keymap.set('n', '[;', dropbar_api.goto_context_start, { desc = 'Go to start of current context' })
        vim.keymap.set('n', '];', dropbar_api.select_next_context, { desc = 'Select next context' })
      end
    },

    {
      "SmiteshP/nvim-navic",
      requires = "neovim/nvim-lspconfig"
    },

    -- Buffer
    { 'akinsho/bufferline.nvim',  version = "*", dependencies = 'nvim-tree/nvim-web-devicons' },

    -- ===========================
    -- Markdown

    --- ノーマルモードで Markdown をリッチに表示する
    --- Deprecated: 2025-03-16
    -- {
    --   'MeanderingProgrammer/render-markdown.nvim',
    --   after = { 'nvim-treesitter' },
    --   requires = { 'echasnovski/mini.nvim', opt = true },
    --   config = function()
    --     require('render-markdown').setup({})
    --   end,
    -- },

    --- ノーマルモードで Markdown をリッチに表示する
    --- @see https://github.com/OXY2DEV/markview.nvim?tab=readme-ov-file
    -- {
    --   "OXY2DEV/markview.nvim",
    --   lazy = false,
    --   config = function()
    --     local presets = require("markview.presets");
    --     require("markview").setup({
    --       markdown = {
    --         headings = presets.headings.marker,
    --         -- horizontal_rules = presets.horizontal_rules.dashed,
    --         tables = presets.tables.rounded, -- none | single | double | rounded | solid

    --       }
    --     })
    --   end,

    --   -- For blink.cmp's completion
    --   -- source
    --   -- dependencies = {
    --   --     "saghen/blink.cmp"
    --   -- },
    -- },


    {
      "iamcco/markdown-preview.nvim",
      cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
      build = "cd app && yarn install",
      init = function()
        vim.g.mkdp_filetypes = { "markdown" }
      end,
      ft = { "markdown" },
    },

    -- {
    --   "3rd/diagram.nvim",
    --   dependencies = {
    --     "3rd/image.nvim",
    --   },
    --   opts = { -- you can just pass {}, defaults below
    --     renderer_options = {
    --       mermaid = {
    --         background = nil, -- nil | "transparent" | "white" | "#hex"
    --         theme = nil,      -- nil | "default" | "dark" | "forest" | "neutral"
    --         scale = 1,        -- nil | 1 (default) | 2  | 3 | ...
    --         width = nil,      -- nil | 800 | 400 | ...
    --         height = nil,     -- nil | 600 | 300 | ...
    --       },
    --       plantuml = {
    --         charset = nil,
    --       },
    --       d2 = {
    --         theme_id = nil,
    --         dark_theme_id = nil,
    --         scale = nil,
    --         layout = nil,
    --         sketch = nil,
    --       },
    --       gnuplot = {
    --         size = nil,  -- nil | "800,600" | ...
    --         font = nil,  -- nil | "Arial,12" | ...
    --         theme = nil, -- nil | "light" | "dark" | custom theme string
    --       },
    --     }
    --   },
    -- },

    -- Memo
    { 'glidenote/memolist.vim' },

    -- Toggle
    { 'monaqa/dial.nvim' },

    -- Procon
    { "krzmknt/procon-utils.nvim" },

    -- Marp
    {
      "mpas/marp-nvim",
      config = function()
        require("marp").setup({
          port = 8080,
          wait_for_response_timeout = 30,
          wait_for_response_delay = 1,
        })
      end,
    },
  },

  install = { colorscheme = { "habamax" } },
  checker = { enabled = false },
})
