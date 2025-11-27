-----------------------------
-- Colorscheme
--

-- Option 1: Use custom theme
vim.cmd("colorscheme custom")

local colors = require("util.color")

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
	bg = colors.bg_d, -- Darker background
})

vim.api.nvim_set_hl(0, "CursorColumn", {
	fg = colors.none,
	bg = colors.bg_d, -- Darker background
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
-- Set both legacy Comment and Treesitter @comment groups
-- Use both guifg (24-bit) and ctermfg (256-color) for compatibility
local comment_color = { fg = "#5c6370", ctermfg = 242, italic = true, force = true }
vim.api.nvim_set_hl(0, "Comment", comment_color)
vim.api.nvim_set_hl(0, "@comment", comment_color)
vim.api.nvim_set_hl(0, "@comment.bash", comment_color)
vim.api.nvim_set_hl(0, "@comment.lua", comment_color)
vim.api.nvim_set_hl(0, "@comment.python", comment_color)
vim.api.nvim_set_hl(0, "@comment.javascript", comment_color)
vim.api.nvim_set_hl(0, "@comment.typescript", comment_color)
vim.api.nvim_set_hl(0, "@comment.documentation", comment_color)
vim.api.nvim_set_hl(0, "@comment.error", comment_color)
vim.api.nvim_set_hl(0, "@comment.warning", comment_color)
vim.api.nvim_set_hl(0, "@comment.todo", comment_color)
vim.api.nvim_set_hl(0, "@comment.note", comment_color)

-- LSP Semantic Tokens for comments
vim.api.nvim_set_hl(0, "@lsp.type.comment", comment_color)
vim.api.nvim_set_hl(0, "@lsp.type.comment.bash", comment_color)

-- Override @spell highlight to prevent it from overriding comment colors
-- @spell is used for spell checking and was making comments white
-- Set it to inherit from the underlying text (NONE)
vim.api.nvim_set_hl(0, "@spell", { fg = "NONE", bg = "NONE", sp = "NONE" })
vim.api.nvim_set_hl(0, "@spell.bash", { link = "@spell" })
vim.api.nvim_set_hl(0, "@spell.lua", { link = "@spell" })
vim.api.nvim_set_hl(0, "@spell.python", { link = "@spell" })
vim.api.nvim_set_hl(0, "@spell.javascript", { link = "@spell" })
vim.api.nvim_set_hl(0, "@spell.typescript", { link = "@spell" })
vim.api.nvim_set_hl(0, "@spell.tsx", { link = "@spell" })
vim.api.nvim_set_hl(0, "@spell.jsx", { link = "@spell" })

-- LSP floating window borders (set AFTER onedark loads to prevent override)
-- Using bright colors for maximum visibility
-- FloatBorder: cyan border with pure black background
-- NormalFloat: pure black background for floating windows (not transparent)
vim.cmd([[
  highlight FloatBorder guifg=#00FFFF guibg=#000000 gui=bold
  highlight NormalFloat guibg=#000000
]])

-- Force override after any colorscheme changes
vim.api.nvim_create_autocmd("ColorScheme", {
	callback = function()
		local comment_hl = { fg = "#5c6370", ctermfg = 242, italic = true, force = true }
		vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#00FFFF", bg = "#000000", bold = true })
		vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#000000" })
		vim.api.nvim_set_hl(0, "Comment", comment_hl)
		vim.api.nvim_set_hl(0, "@comment", comment_hl)
		vim.api.nvim_set_hl(0, "@comment.bash", comment_hl)
		vim.api.nvim_set_hl(0, "@comment.lua", comment_hl)
		vim.api.nvim_set_hl(0, "@comment.python", comment_hl)
		vim.api.nvim_set_hl(0, "@comment.javascript", comment_hl)
		vim.api.nvim_set_hl(0, "@comment.typescript", comment_hl)
		vim.api.nvim_set_hl(0, "@comment.documentation", comment_hl)
		vim.api.nvim_set_hl(0, "@comment.error", comment_hl)
		vim.api.nvim_set_hl(0, "@comment.warning", comment_hl)
		vim.api.nvim_set_hl(0, "@comment.todo", comment_hl)
		vim.api.nvim_set_hl(0, "@comment.note", comment_hl)
		vim.api.nvim_set_hl(0, "@lsp.type.comment", comment_hl)
		vim.api.nvim_set_hl(0, "@lsp.type.comment.bash", comment_hl)
		-- Override @spell to prevent overriding comment colors
		vim.api.nvim_set_hl(0, "@spell", { fg = "NONE", bg = "NONE", sp = "NONE" })
		vim.api.nvim_set_hl(0, "@spell.bash", { link = "@spell" })
		vim.api.nvim_set_hl(0, "@spell.lua", { link = "@spell" })
		vim.api.nvim_set_hl(0, "@spell.python", { link = "@spell" })
		vim.api.nvim_set_hl(0, "@spell.javascript", { link = "@spell" })
		vim.api.nvim_set_hl(0, "@spell.typescript", { link = "@spell" })
		vim.api.nvim_set_hl(0, "@spell.tsx", { link = "@spell" })
		vim.api.nvim_set_hl(0, "@spell.jsx", { link = "@spell" })
	end,
})
