local icons = require("util.icons")
local colors = require("util.color")

-- Load plugin
local pluginLoader = require("util.pluginLoader")
local lualine = pluginLoader.load({ pluginName = "lualine", enable = true })
if lualine == nil then return end

local theme = {
  normal = {
    a = { fg = colors.white, bg = colors.dark_cyan },
    b = { fg = colors.white, bg = colors.grey },
    c = { fg = colors.light_grey, bg = colors.none },
  },

  insert = { a = { fg = colors.black, bg = colors.yellow } },
  visual = { a = { fg = colors.white, bg = colors.red } },
  replace = { a = { fg = colors.white, bg = colors.red } },

  inactive = {
    a = { fg = colors.white, bg = colors.none },
    b = { fg = colors.white, bg = colors.none },
    c = { fg = colors.black, bg = colors.none },
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
        fmt = function(mode) return icons.mode[mode] end,
        icons_enabled = true,
        separator = {
          left = icons.separator.rounded.left,
          right = ' ',
        },
        padding = { left = 0, right = 1 },
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
      {
        'filename',
        color = { bg = 'null' },
        padding = { left = 1, right = 1 },
        file_status = true,     -- Displays file status (readonly status, modified status)
        newfile_status = false, -- Display new file status (new file means no write after created)
        path = 1,               -- 0: Just the filename
        -- 1: Relative path
        -- 2: Absolute path
        -- 3: Absolute path, with tilde as the home directory
        -- 4: Filename and parent dir, with tilde as the home directory

        shorting_target = 40, -- Shortens path to leave 40 spaces in the window

        symbols = {
          modified = '[Unsaved]', -- Text to show when the file is modified.
          readonly = '[RO]',      -- Text to show when the file is non-modifiable or readonly.
          unnamed = '[No Name]',  -- Text to show for unnamed buffers.
          newfile = '[New]',      -- Text to show for newly created file before first write
        }
      },
      { 'bo:filetype' }
    },

    lualine_x = {
      {
        'diagnostics',
        color = { bg = 'null' },
        sources = { 'nvim_lsp' },
        symbols = {
          error = icons.diagnostic.error,
          warn = icons.diagnostic.warn,
          info = icons.diagnostic.info,
          hint = icons.diagnostic.hint,
        },

        always_visible = true,
        update_in_insert = true,
        colored = true,
      },
    },

    lualine_y = {
      {
        'filetype',
        colored = true,
        icon_only = false,
        icon = { align = 'left' },
        separator = {
          left = icons.separator.rounded.left,
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
          unix = icons.platform.unix,
          dos = icons.platform.windows,
          mac = icons.platform.mac,
        },
      },
    },

    lualine_z = {
      {
        'location',
        padding = { left = 0, right = 0 },
        separator = {
          left = icons.separator.rounded.left,
          right = ''
        },
      },

      {
        'searchcount',
        maxcount = 999,
        timeout = 500,
      },

      {
        'progress',
        separator = {
          left = ' ',
          right = icons.separator.rounded.right,
        },
      }

    },
  },

  tabline = {},
  extensions = {}
}
