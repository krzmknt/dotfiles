local icons = require("util.icons")
local colors = require("util.color")

-- Load plugin
local pluginLoader = require("util.pluginLoader")
local lualine = pluginLoader.load({ pluginName = "lualine", enable = true })
if lualine == nil then return end

local theme = {
  normal = {
    a = { fg = colors.dark_cyan, bg = colors.black },  -- Dark bg, text color is the old bg color
    b = { fg = colors.white, bg = colors.black },
    c = { fg = colors.white, bg = colors.black },
  },

  insert = { a = { fg = colors.yellow, bg = colors.black } },  -- Dark bg, text color is the old bg color
  visual = { a = { fg = colors.red, bg = colors.black } },     -- Dark bg, text color is the old bg color
  replace = { a = { fg = colors.red, bg = colors.black } },    -- Dark bg, text color is the old bg color

  inactive = {
    a = { fg = colors.white, bg = colors.black },
    b = { fg = colors.white, bg = colors.black },
    c = { fg = colors.white, bg = colors.black },
  },
}

lualine.setup {
  options = {
    icons_enabled = true,
    theme = theme,
    section_separators = { left = '', right = '' },
    component_separators = { left = '', right = '' },
    disabled_filetypes = {},
    draw_empty = false,
  },

  sections = {
    lualine_a = {
      {
        'mode',
        fmt = function(mode) return ' ' .. icons.mode[mode] .. ' ' end,  -- Add spaces for thickness
        icons_enabled = true,
        separator = {
          left = "",  -- Rounded left border
          right = ""  -- Rounded right border
        },
        padding = { left = 1, right = 1 },  -- Increased padding for thicker appearance
      },
    },

    lualine_b = {
      {
        'branch',
        draw_empty = false,
        padding = { left = 1, right = 1 },
      },

      {
        'diff',
        colored = true,
        draw_empty = true,
        padding = { left = 0, right = 1 },
        separator = {
          left = ' ',
          right = ' '
        },
      },

    },

    lualine_c = {
      -- Section C removed - not needed
    },

    lualine_x = {
      {
        'diagnostics',
        colored = true,
        sources = { 'nvim_lsp' },
        symbols = {
          error = icons.diagnostic.error,
          warn = icons.diagnostic.warn,
          info = icons.diagnostic.info,
          hint = icons.diagnostic.hint,
        },
        always_visible = true,
        update_in_insert = true,
      },
    },

    lualine_y = {
      {
        'filetype',
        colored = true,
        icon_only = false,
        icon = { align = 'left' },
        separator = {
          left = '',
          right = ''
        },
        padding = { left = 1, right = 1 },
      },

      {
        'encoding',
        show_bomb = true,
        padding = { left = 0, right = 1 },
      },

      {
        'fileformat',
        padding = { left = 0, right = 2 },
        symbols = {
          unix = 'LF',     -- Unix line ending
          dos = 'CRLF',    -- Windows line ending
          mac = 'CR',      -- Mac line ending
        },
      },
    },

    lualine_z = {
      -- Disabled location (line:col) since we show column number at window edge
      -- {
      --   'location',
      --   padding = { left = 0.2, right = 0.2 },
      --   separator = {
      --     left = '',
      --     right = ''
      --   },
      -- },

      -- {
      --   'searchcount',
      --   maxcount = 999,
      --   timeout = 500,
      -- },

      -- {
      --   'progress',
      --   separator = {
      --     left = ' ',
      --     right = icons.separator.rounded.right,
      --   },
      -- }

    },
  },

  tabline = {},
  extensions = {}
}
