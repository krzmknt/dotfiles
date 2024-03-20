local status, lualine = pcall(require, "lualine")
if (not status) then return end

-- Icons for the vim modes
local mode_icons = {
  ["NORMAL"]  = "",
  ["INSERT"]  = "",
  ["V-LINE"]  = "󰍉",
  ["V-BLOCK"] = "󰍉",
  ["COMMAND"] = "",
}

local colors = {
  transparent = 'none',
  white       = '#cdcdcd',
  black       = '#000000',
  grey        = '#2c323c',
  light_grey  = '#555555',
  blue        = '#255D83',
  yellow      = '#E0C050',
  framingo    = '#ff687e',
}

local theme = {
  normal = {
    a = { fg = colors.white, bg = colors.blue },
    b = { fg = colors.white, bg = colors.grey },
    c = { fg = colors.light_grey, bg = colors.transparent },
  },

  insert = { a = { fg = colors.black, bg = colors.yellow } },
  visual = { a = { fg = colors.white, bg = colors.framingo } },
  replace = { a = { fg = colors.white, bg = colors.framingo } },

  inactive = {
    a = { fg = colors.white, bg = colors.transparent },
    b = { fg = colors.white, bg = colors.transparent },
    c = { fg = colors.black, bg = colors.transparent },
  },
}


lualine.setup {
  options = {
    icons_enabled = true,
    theme = theme,
    section_separators = { left = '', right = '' },
    -- component_separators = { left = '', right = '' },
    component_separators = { left = '', right = '' },
    disabled_filetypes = {},
    draw_empty = false,
  },

  sections = {
    lualine_a = {
      {
        'mode',
        fmt = function(mode) return mode_icons[mode] end, -- Format function or string to format the component's value.
        icons_enabled = true,                             -- Enables the display of icons alongside the component.
        separator = { left = '', right = '' },
        padding = { left = 0, right = 1 },
      }
    },

    lualine_b = {
      {
        'branch',
        draw_empty = false, -- Whether to draw component even if it's empty.
        padding = { left = 1, right = 1 },
      },

      {
        'diff',
        colored = true,    -- Displays a colored diff status if set to true
        draw_empty = true, -- Whether to draw component even if it's empty.
        separator = { left = '', right = '' },
        padding = { left = 0, right = 1 },
      }
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
        -- for other components. (terrible name, any suggestions?)
        symbols = {
          modified = '[+]',      -- Text to show when the file is modified.
          readonly = '[-]',      -- Text to show when the file is non-modifiable or readonly.
          unnamed = '[No Name]', -- Text to show for unnamed buffers.
          newfile = '[New]',     -- Text to show for newly created file before first write
        }
      },
      { '', color = { bg = '#abcdef' } }, -- 空のコンポーネントで背景色を変更
    },

    lualine_x = {
      { '', color = { bg = '#abcdef' } }, -- 空のコンポーネントで背景色を変更
      {
        'diagnostics',
        color = { bg = 'null' },
        sources = { 'coc' },
        symbols = {
          error = ' ',
          warn = ' ',
          info = ' ',
          hint = ' '
        },
        always_visible = false,  -- Show diagnostics even if there are none.
        update_in_insert = true, -- Update diagnostics in insert mode.
        colored = true,          -- Displays diagnostics status in color if set to true.
      },
    },

    lualine_y = {
      {
        'filetype',
        colored = true,            -- Displays filetype icon in color if set to true
        icon_only = false,         -- Display only an icon for filetype
        icon = { align = 'left' }, -- Display filetype icon on the right hand side
        separator = { left = '', right = '' },
        padding = { left = 1, right = 1 },
      },

      {
        'encoding',
        padding = { left = 0, right = 1 },
      },

      {
        'fileformat',
        padding = { left = 0, right = 1 },
        symbols = {
          unix = ' ',
          dos = ' ',
          mac = ' '
        },
      },
    },

    lualine_z = {
      -- {
      --   'progress',
      --   separator = { left = '', right = '' },
      --   padding = { left = 1, right = 1 },
      -- },

      {
        'location',
        padding = { left = 0, right = 0 },
        separator = { left = '', right = '' },
      }
    }
  },

  tabline = {},
  extensions = {}
}
