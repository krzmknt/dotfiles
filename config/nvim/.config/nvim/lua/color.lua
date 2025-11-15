-----------------------------
-- Colorscheme
--
local colors = require("util.color")
local pluginLoader = require("util.pluginLoader")
local onedark = pluginLoader.load({ pluginName = "onedark", enable = true })
if onedark == nil then return end

require("onedark").setup {
  style = 'darker',
  transparent = true
}
require('onedark').load()


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
  fg = colors.none,
  bg = colors.deep_blue,
})

vim.api.nvim_set_hl(0, "CursorColumn", {
  fg = colors.none,
  bg = colors.deep_blue,
})

vim.api.nvim_set_hl(0, "Cursor", {
  fg = colors.none,
  bg = colors.purple,
})

vim.api.nvim_set_hl(0, "MatchParen", {
  fg = colors.none,
  bg = colors.purple,
})

-- GitSigns

vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = colors.git.add })
vim.api.nvim_set_hl(0, "GitSignsChange", { fg = colors.git.change })
vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = colors.git.delete })

vim.cmd([[highlight! link GitSignsAddNr GitSignsAddNr]])
vim.cmd([[highlight! link GitSignsChangeNr GitSignsChangeNr]])
vim.cmd([[highlight! link GitSignsDeleteNr GitSignsDeleteNr]])

vim.api.nvim_set_hl(0, "GitSignsAddLn", { bg = colors.none })
vim.api.nvim_set_hl(0, "GitSignsChangeLn", { bg = colors.none })
vim.api.nvim_set_hl(0, "GitSignsDeleteLn", { bg = colors.none })

vim.api.nvim_set_hl(0, "GitSignsAddNr", { fg = colors.git.add })
vim.api.nvim_set_hl(0, "GitSignsChangeNr", { fg = colors.git.change })
vim.api.nvim_set_hl(0, "GitSignsDeleteNr", { fg = colors.git.delete })

-- Diffview

vim.api.nvim_set_hl(0, "DiffAdd", { bg = colors.none })
vim.api.nvim_set_hl(0, "DiffChange", { bg = colors.none })

-- indent-blankline
vim.api.nvim_set_hl(0, "IblScope", { fg = colors.purple }) -- Set your desired color


-- Comment color (ensure comments are not white)
vim.api.nvim_set_hl(0, 'Comment', { fg = colors.light_grey, italic = true })

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
