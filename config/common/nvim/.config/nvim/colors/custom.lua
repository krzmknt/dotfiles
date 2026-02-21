-- Custom Neovim Theme
-- A modern dark colorscheme with carefully chosen colors

vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") then
	vim.cmd("syntax reset")
end

vim.o.termguicolors = true
vim.g.colors_name = "custom"

-- Color Palette - Vivid & Vibrant
-- Store in global so plugins can access via _G.CustomColors
local colors = {
	-- Base colors
	bg = "NONE", -- Transparent background
	bg_dark = "NONE", -- Transparent background
	bg_light = "#1a1f2e", -- Lighter background (for popups, sidebars)
	fg = "#e6edf3", -- Main foreground text (brighter)
	fg_dark = "#9ca3af", -- Darker foreground (comments - brighter)
	fg_light = "#ffffff", -- Lighter foreground (pure white)

	-- Syntax colors - More Vivid!
	red = "#ff6b6b", -- Bright red - Errors, deleted, constants
	orange = "#ffa500", -- Vivid orange - Warnings, special
	yellow = "#ffff00", -- Pure yellow - Modified, strings
	green = "#00ff7f", -- Spring green - Added, strings
	cyan = "#00ffff", -- Bright cyan - Functions, methods
	blue = "#5b9cff", -- Vivid blue - Keywords, types
	purple = "#e879f9", -- Hot pink purple - Variables, properties
	pink = "#ff69b4", -- Hot pink - Special, regex

	-- UI colors
	gray = "#5a6270", -- Borders, inactive
	gray_light = "#8a92a0", -- Line numbers (brighter)
	light_grey = "#5c6370", -- Alternative gray
	selection = "#3b82f6", -- Bright blue selection
	search = "#ffff00", -- Bright yellow search
	diff_add = "#00ff7f", -- Bright green
	diff_delete = "#ff6b6b", -- Bright red
	diff_change = "#ffa500", -- Bright orange

	-- Additional colors for compatibility with util.color
	none = "none",
	white = "#cdcdcd",
	diff_text = "#274964",
	bg0 = "#1f2329",
	bg1 = "#282c34",
	bg2 = "#30363f",
	bg3 = "#323641",
	bg_blue = "#61afef",
	bg_d = "#181b20",
	bg_yellow = "#e8c88c",
	black = "#0e1013",
	dark_cyan = "#266269",
	dark_purple = "#7e3992",
	dark_red = "#8b3434",
	dark_yellow = "#835d1a",
	deep_blue = "#17263D",
	a = "#A8DADC",
	b = "#457B9D",
	c = "#1D3557",

	-- Diagnostic colors
	diagnostic = {
		error = "#E06C75",
		warn = "#E5C07B",
		info = "#61AFEF",
		hint = "#56B6C2",
	},

	-- Git colors (unified)
	git = {
		add = "#00ff7f", -- green
		change = "#ffa500", -- orange
		delete = "#ff6b6b", -- red
	},
}

-- Helper function to set highlights
local function hi(group, opts)
	local cmd = "highlight " .. group
	if opts.fg then
		cmd = cmd .. " guifg=" .. opts.fg
	end
	if opts.bg then
		cmd = cmd .. " guibg=" .. opts.bg
	end
	if opts.sp then
		cmd = cmd .. " guisp=" .. opts.sp
	end
	if opts.bold then
		cmd = cmd .. " gui=bold"
	end
	if opts.italic then
		cmd = cmd .. " gui=italic"
	end
	if opts.underline then
		cmd = cmd .. " gui=underline"
	end
	if opts.undercurl then
		cmd = cmd .. " gui=undercurl"
	end
	if opts.reverse then
		cmd = cmd .. " gui=reverse"
	end
	if opts.link then
		cmd = "highlight! link " .. group .. " " .. opts.link
	end
	vim.cmd(cmd)
end

-- Editor UI
hi("Normal", { fg = colors.fg, bg = "NONE" })
hi("NormalFloat", { fg = colors.fg, bg = "#000000" })
hi("FloatBorder", { fg = colors.cyan, bg = "#000000", bold = true })
hi("Cursor", { bg = colors.purple })
hi("CursorLine", { bg = colors.bg_d })
hi("CursorColumn", { bg = colors.bg_d })
hi("LineNr", { fg = colors.gray_light, bg = "NONE" })
hi("CursorLineNr", { fg = colors.purple, bg = "NONE", bold = true })
hi("SignColumn", { bg = "NONE" })
hi("ColorColumn", { bg = colors.bg_light })
hi("VertSplit", { fg = "#2a2e36", bg = "NONE" })
hi("WinSeparator", { fg = "#2a2e36", bg = "NONE" })
hi("StatusLine", { fg = colors.fg, bg = "NONE" })
hi("StatusLineNC", { fg = colors.fg_dark, bg = "NONE" })
hi("TabLine", { bg = "NONE" })
hi("TabLineSel", { fg = colors.black, bg = colors.purple, bold = true })
hi("TabLineFill", { bg = "NONE" })
hi("Visual", { bg = colors.selection })
hi("Search", { fg = colors.bg, bg = colors.search })
hi("IncSearch", { fg = colors.bg, bg = colors.orange })
hi("Pmenu", { fg = colors.fg, bg = colors.bg_light })
hi("PmenuSel", { fg = colors.bg, bg = colors.purple })
hi("PmenuSbar", { bg = colors.gray })
hi("PmenuThumb", { bg = colors.gray_light })
hi("MatchParen", { bg = colors.purple })

-- Syntax Highlighting
hi("Comment", { fg = colors.fg_dark, italic = true })
hi("Constant", { fg = colors.red })
hi("String", { fg = colors.green })
hi("Character", { fg = colors.green })
hi("Number", { fg = colors.orange })
hi("Boolean", { fg = colors.red })
hi("Float", { fg = colors.orange })
hi("Identifier", { fg = colors.purple })
hi("Function", { fg = colors.cyan })
hi("Statement", { fg = colors.blue })
hi("Conditional", { fg = colors.blue })
hi("Repeat", { fg = colors.blue })
hi("Label", { fg = colors.blue })
hi("Operator", { fg = colors.red })
hi("Keyword", { fg = colors.blue })
hi("Exception", { fg = colors.red })
hi("PreProc", { fg = colors.pink })
hi("Include", { fg = colors.pink })
hi("Define", { fg = colors.pink })
hi("Macro", { fg = colors.pink })
hi("PreCondit", { fg = colors.pink })
hi("Type", { fg = colors.yellow })
hi("StorageClass", { fg = colors.blue })
hi("Structure", { fg = colors.yellow })
hi("Typedef", { fg = colors.yellow })
hi("Special", { fg = colors.orange })
hi("SpecialChar", { fg = colors.orange })
hi("Tag", { fg = colors.cyan })
hi("Delimiter", { fg = colors.fg })
hi("SpecialComment", { fg = colors.gray_light, italic = true })
hi("Debug", { fg = colors.red })
hi("Underlined", { fg = colors.blue, underline = true })
hi("Error", { fg = colors.red })
hi("Todo", { fg = colors.purple, bold = true })

-- Treesitter
hi("@variable", { fg = colors.fg })
hi("@variable.builtin", { fg = colors.red })
hi("@variable.parameter", { fg = colors.orange })
hi("@variable.member", { fg = colors.purple })
hi("@constant", { fg = colors.red })
hi("@constant.builtin", { fg = colors.red })
hi("@module", { fg = colors.yellow })
hi("@label", { fg = colors.blue })
hi("@string", { fg = colors.green })
hi("@string.escape", { fg = colors.orange })
hi("@string.regex", { fg = colors.pink })
hi("@character", { fg = colors.green })
hi("@number", { fg = colors.orange })
hi("@boolean", { fg = colors.red })
hi("@float", { fg = colors.orange })
hi("@function", { fg = colors.cyan })
hi("@function.builtin", { fg = colors.cyan })
hi("@function.macro", { fg = colors.pink })
hi("@function.method", { fg = colors.cyan })
hi("@constructor", { fg = colors.yellow })
hi("@keyword", { fg = colors.blue })
hi("@keyword.function", { fg = colors.blue })
hi("@keyword.operator", { fg = colors.blue })
hi("@keyword.return", { fg = colors.blue })
hi("@conditional", { fg = colors.blue })
hi("@repeat", { fg = colors.blue })
hi("@operator", { fg = colors.red })
hi("@type", { fg = colors.yellow })
hi("@type.builtin", { fg = colors.yellow })
hi("@property", { fg = colors.purple })
hi("@tag", { fg = colors.cyan })
hi("@tag.attribute", { fg = colors.purple })
hi("@tag.delimiter", { fg = colors.gray_light })
hi("@punctuation.delimiter", { fg = colors.fg })
hi("@punctuation.bracket", { fg = colors.fg })
hi("@comment", { fg = colors.fg_dark, italic = true })

-- LSP
hi("DiagnosticError", { fg = colors.red })
hi("DiagnosticWarn", { fg = colors.orange })
hi("DiagnosticInfo", { fg = colors.cyan })
hi("DiagnosticHint", { fg = colors.gray_light })
hi("DiagnosticUnderlineError", { sp = colors.red, undercurl = true })
hi("DiagnosticUnderlineWarn", { sp = colors.orange, undercurl = true })
hi("DiagnosticUnderlineInfo", { sp = colors.cyan, undercurl = true })
hi("DiagnosticUnderlineHint", { sp = colors.gray_light, undercurl = true })

-- Git
hi("DiffAdd", { bg = "NONE" })
hi("DiffChange", { bg = "NONE" })
hi("DiffDelete", { fg = colors.red, bg = "NONE" })
hi("DiffText", { fg = colors.yellow, bg = colors.bg_light })
hi("GitSignsAdd", { fg = colors.git.add })
hi("GitSignsChange", { fg = colors.git.change })
hi("GitSignsDelete", { fg = colors.git.delete })
hi("GitSignsAddNr", { fg = colors.git.add })
hi("GitSignsChangeNr", { fg = colors.git.change })
hi("GitSignsDeleteNr", { fg = colors.git.delete })
hi("GitSignsAddLn", { bg = "NONE" })
hi("GitSignsChangeLn", { bg = "NONE" })
hi("GitSignsDeleteLn", { bg = "NONE" })

-- Telescope
hi("TelescopeBorder", { fg = colors.cyan })
hi("TelescopePromptPrefix", { fg = colors.purple })
hi("TelescopeSelection", { fg = colors.fg_light, bg = colors.bg_light, bold = true })
hi("TelescopeMatching", { fg = colors.orange, bold = true })

-- nvim-tree
hi("NvimTreeNormal", { fg = colors.fg, bg = "NONE" })
hi("NvimTreeNormalNC", { fg = colors.fg, bg = "NONE" })
hi("NvimTreeEndOfBuffer", { bg = "NONE" })
hi("NvimTreeVertSplit", { fg = "#2a2e36", bg = "NONE" })
hi("NvimTreeWinSeparator", { fg = "#2a2e36", bg = "NONE" })
hi("NvimTreeStatusLine", { bg = "NONE" })
hi("NvimTreeStatusLineNC", { bg = "NONE" })
hi("NvimTreeCursorLine", { bg = colors.bg_d })
hi("NvimTreeFolderName", { fg = colors.blue, bg = "NONE" })
hi("NvimTreeFolderIcon", { fg = colors.blue, bg = "NONE" })
hi("NvimTreeOpenedFolderName", { fg = colors.blue, bg = "NONE", bold = true })
hi("NvimTreeRootFolder", { fg = colors.purple, bg = "NONE", bold = true })
hi("NvimTreeIndentMarker", { fg = colors.gray, bg = "NONE" })
hi("NvimTreeGitDirty", { fg = colors.git.change, bg = "NONE" })
hi("NvimTreeGitNew", { fg = colors.git.add, bg = "NONE" })
hi("NvimTreeGitDeleted", { fg = colors.git.delete, bg = "NONE" })

-- Indent Blankline
hi("IblIndent", { fg = colors.gray })
hi("IblScope", { fg = colors.purple })

-- WinBar (dropbar.nvim)
hi("WinBar", { fg = colors.fg, bg = "NONE" })
hi("WinBarNC", { fg = colors.fg_dark, bg = "NONE" })

-- Comment colors (ensure comments are gray, not white)
hi("@comment", { fg = colors.light_grey, italic = true })
hi("@comment.bash", { fg = colors.light_grey, italic = true })
hi("@comment.lua", { fg = colors.light_grey, italic = true })
hi("@comment.python", { fg = colors.light_grey, italic = true })
hi("@comment.javascript", { fg = colors.light_grey, italic = true })
hi("@comment.typescript", { fg = colors.light_grey, italic = true })
hi("@comment.documentation", { fg = colors.light_grey, italic = true })
hi("@lsp.type.comment", { fg = colors.light_grey, italic = true })

-- Markdown
hi("@markup.heading.1.markdown", { fg = colors.red, bold = true })
hi("@markup.heading.2.markdown", { fg = colors.orange, bold = true })
hi("@markup.heading.3.markdown", { fg = colors.yellow, bold = true })
hi("@markup.heading.4.markdown", { fg = colors.green, bold = true })
hi("@markup.heading.5.markdown", { fg = colors.cyan, bold = true })
hi("@markup.heading.6.markdown", { fg = colors.blue, bold = true })
hi("@markup.heading.1.marker.markdown", { fg = colors.red, bold = true })
hi("@markup.heading.2.marker.markdown", { fg = colors.orange, bold = true })
hi("@markup.heading.3.marker.markdown", { fg = colors.yellow, bold = true })
hi("@markup.heading.4.marker.markdown", { fg = colors.green, bold = true })
hi("@markup.heading.5.marker.markdown", { fg = colors.cyan, bold = true })
hi("@markup.heading.6.marker.markdown", { fg = colors.blue, bold = true })
hi("@markup.strong", { fg = colors.fg_light, bold = true })
hi("@markup.italic", { fg = colors.fg_light, italic = true })
hi("@markup.strikethrough", { fg = colors.fg_dark })
hi("@markup.link.markdown_inline", { fg = colors.cyan, underline = true })
hi("@markup.link.url.markdown_inline", { fg = colors.gray_light })
hi("@markup.link.label.markdown_inline", { fg = colors.cyan })
hi("@markup.raw", { fg = colors.green })
hi("@markup.raw.block.markdown", { fg = colors.green })
hi("@markup.list.markdown", { fg = colors.blue })
hi("@punctuation.special.markdown", { fg = colors.gray_light })

-- Override @spell to prevent it from overriding comment colors
-- Use nvim_set_hl because @spell may not exist yet at colorscheme load time
vim.api.nvim_set_hl(0, "@spell", {})

-- Store colors in global for plugins to access
_G.CustomColors = colors

return colors
