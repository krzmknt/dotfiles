-----------------------------
-- Colorscheme
--

-- vim.cmd('colorscheme flexoki-dark')
-- vim.cmd [[colorscheme catppuccin]]

require('onedark').setup {
  style = 'darker',
  transparent = true
}
require('onedark').load()

local colors = {
  bg0 = "#1f2329",
  bg1 = "#282c34",
  bg2 = "#30363f",
  bg3 = "#323641",
  bg_blue = "#61afef",
  bg_d = "#181b20",
  bg_yellow = "#e8c88c",
  black = "#0e1013",
  blue = "#4fa6ed",
  cyan = "#48b0bd",
  dark_cyan = "#266269",
  dark_purple = "#7e3992",
  dark_red = "#8b3434",
  dark_yellow = "#835d1a",
  diff_add = "#272e23",
  diff_change = "#172a3a",
  diff_delete = "#2d2223",
  diff_text = "#274964",
  fg = "#a0a8b7",
  green = "#8ebd6b",
  grey = "#535965",
  light_grey = "#7a818e",
  none = "none",
  orange = "#cc9057",
  purple = "#bf68d9",
  red = "#e55561",
  yellow = "#e2b86b"
}

-- :lua print(vim.inspect(require('onedark.colors')))
-- local colors = require('onedark.colors')

vim.api.nvim_set_hl(0, "TabLine", {
  fg = colors.none,
  bg = colors.none,
})

vim.api.nvim_set_hl(0, "TabLineSel", {
  fg = colors.black,
  bg = colors.purple,
})

vim.api.nvim_set_hl(0, "TabLineFill", {
  fg = colors.none,
  bg = colors.none,
})

vim.api.nvim_set_hl(0, "CursorLine", {
  fg = "none",
  bg = "#333333"
})

vim.api.nvim_set_hl(0, "CursorColumn", {
  fg = "none",
  bg = "#333333"
})

vim.api.nvim_set_hl(0, "Cursor", {
  fg = "none",
  bg = colors.purple,
})

vim.api.nvim_set_hl(0, "MatchParen", {
  fg = "none",
  bg = colors.purple,
})

-- GitSigns

vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = colors.green })
vim.api.nvim_set_hl(0, "GitSignsChange", { fg = colors.blue })
vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = colors.red })

vim.cmd([[highlight! link GitSignsAddNr GitSignsAddNr]])
vim.cmd([[highlight! link GitSignsChangeNr GitSignsChangeNr]])
vim.cmd([[highlight! link GitSignsDeleteNr GitSignsDeleteNr]])

vim.api.nvim_set_hl(0, "GitSignsAddLn", { bg = colors.none })
vim.api.nvim_set_hl(0, "GitSignsChangeLn", { bg = colors.none })
vim.api.nvim_set_hl(0, "GitSignsDeleteLn", { bg = colors.none })

vim.api.nvim_set_hl(0, "GitSignsAddNr", { fg = colors.green })
vim.api.nvim_set_hl(0, "GitSignsChangeNr", { fg = colors.blue })
vim.api.nvim_set_hl(0, "GitSignsDeleteNr", { fg = colors.red })

-- Diffview

vim.api.nvim_set_hl(0, "DiffAdd", { bg = colors.none })
vim.api.nvim_set_hl(0, "DiffChange", { bg = colors.none })

-- indent-blankline
vim.api.nvim_set_hl(0, "IblScope", { fg = colors.purple }) -- Set your desired color


-- coc

-- エラーに波線を適用
vim.api.nvim_set_hl(0, 'CocErrorHighlight', { bg = colors.red, fg = 'Yellow' })

-- -- 警告に波線を適用
-- vim.api.nvim_set_hl(0, 'CocWarningHighlight', { cterm = 'undercurl', gui = 'undercurl', sp = 'Yellow' })
--
-- -- 情報に波線を適用
-- vim.api.nvim_set_hl(0, 'CocInfoHighlight', { cterm = 'undercurl', gui = 'undercurl', sp = 'Blue' })
--
-- -- ヒントに波線を適用
-- vim.api.nvim_set_hl(0, 'CocHintHighlight', { cterm = 'undercurl', gui = 'undercurl', sp = 'Cyan' })
