-----------------------------
-- Neovim Options Configuration
-----------------------------

local options = {
	-----------------------------
	-- Mode
	-----------------------------
	showmode = false, -- Don't show the mode since we use a statusline plugin.
	laststatus = 0, -- Disable bottom statusline (using winbar instead)

	-----------------------------
	-- Color
	-----------------------------
	termguicolors = true, -- Use true colors in the terminal.

	-----------------------------
	-- Pop-up menu / Floating window
	-----------------------------
	pumblend = 20, -- Popup menu transparency.
	pumheight = 20, -- Popup menu height.
	winblend = 0, -- Floating window transparency.

	-----------------------------
	-- Cursor
	-----------------------------
	cursorline = true, -- Highlight the current line.
	cursorcolumn = true, -- Highlight the current column.
	cursorlineopt = { "line", "number" }, -- Highlight the current line and number.
	scrolloff = 10, -- Minumum number of lines to keep above and below the cursor.
	sidescrolloff = 10, -- Minimum number of columns to keep to the left and right of the cursor.

	-----------------------------
	-- Mouse
	-----------------------------
	mouse = "a", -- Enable mouse support for all modes.
	mousehide = true, -- Hide the mouse pointer while typing.
	mousemodel = "extend", -- Use right mouse button to extend selection.
	mousescroll = "ver:1,hor:1", -- the number of lines / columns to scroll by when scrolling with a mouse wheel.

	-----------------------------
	-- Command line
	-----------------------------
	cmdheight = 1, -- Command line height.
	cmdwinheight = 7, -- Command window height.
	wildoptions = "pum", -- Show the popup menu when pressing <Tab> in the command-line.

	-----------------------------
	-- Completion
	-----------------------------
	completeopt = { "menuone", "noselect" },
	complete = { ".", "w", "b", "u", "t" },

	-----------------------------
	-- Wrap
	-----------------------------
	wrap = true, -- Line wrapping.
	linebreak = true, -- Wrap long lines at a character in 'breakat' rather than at the last character that fits on the screen.
	breakat = " ^I!@*-+;:,./?", -- This option lets you choose which characters might cause a line break if 'linebreak' is on.  Only works for ASCII characters.
	breakindent = true, -- Every wrapped line will continue visually indented (same amount of space as the beginning of that line), thus preserving horizontal blocks of text.
	wrapmargin = 1, -- Number of columns from the right window border where wrapping starts.
	whichwrap = "b,s,<,>,[,],h,l", -- Allow certain movements to wrap around lines.

	-----------------------------
	-- Fold
	-----------------------------
	foldenable = false, -- Whether folding is enabled.
	foldmethod = "syntax", -- Folding method.
	foldcolumn = "auto", -- When and how to draw the foldcolumn.
	foldlevel = 0, -- Folds with a higher level will be closed.
	foldnestmax = 10, -- The maximum nesting of folds for the "indent" and "syntax" methods.
	foldminlines = 10, -- The minimum number of lines for a fold.
	foldopen = {
		"block",
		"hor",
		"insert",
		"jump",
		"mark",
		"percent",
		"quickfix",
		"search",
		"tag",
		"undo",
	},
	foldclose = "all", -- Close all folds when the cursor moves out of them.
	foldignore = "#/", -- Don't ignore any folds.

	-----------------------------
	-- Sign Column
	-----------------------------
	signcolumn = "yes", -- Always show the sign column.

	-----------------------------
	-- Number column
	-----------------------------
	number = true, -- Show line numbers.
	numberwidth = 1, -- Minimum width (auto-expands as needed).
	relativenumber = true, -- Show relative line numbers.
	statuscolumn = "%s%=%{v:relnum?v:relnum:v:lnum} ", -- Show signs (left) and right-align line numbers.

	-----------------------------
	-- Clipboard
	-----------------------------
	clipboard = "unnamedplus", -- Use the system clipboard.

	-----------------------------
	-- Indentation
	-----------------------------
	expandtab = true, -- Use spaces instead of tabs.
	smartindent = true, -- Smart indentation.
	shiftwidth = 2, -- Identation width for >>, <<, etc.
	tabstop = 2, -- Number of spaces that a <Tab> in the file counts for.
	showtabline = 2, -- Always show the tabline.

	-----------------------------
	-- Search and Replace
	-----------------------------
	hlsearch = true, -- Highlight search results.
	ignorecase = true, -- Ignore case when searching.
	smartcase = true, -- Override 'ignorecase' if the search pattern contains upper case characters.
	incsearch = true, -- Incremental search.

	-----------------------------
	-- Backup
	-----------------------------
	backup = false, -- Disable backup files.
	backupskip = { "/tmp/*", "/private/tmp/*" }, -- Skip backups for temporary files.
	swapfile = false, -- Disable swap files.
	undofile = true, -- Enable persistent undo.
	writebackup = false, -- Disable backup files.

	-----------------------------
	-- Encoding and File format
	-----------------------------
	encoding = "utf-8", -- String-encoding used internally and for RPC communication.
	fileencoding = "utf-8", -- File encoding.
	fileencodings = { "utf-8" }, -- List of file encodings to try when starting to edit an existing file.
	fileformat = "unix", -- <NL>
	fileformats = { "unix" }, -- Permitted value is

	-----------------------------
	-- Terminal
	-----------------------------
	shell = "fish", -- Default shell.

	-----------------------------
	-- Window
	-----------------------------
	splitbelow = true, -- When on, splitting a window will put the new window below the current one.
	splitright = true, -- When on, splitting a window will put the new window right of the current one.

	-----------------------------
	-- Word
	-----------------------------
	iskeyword = "@,48-57,_,192-255,-", -- Treat dash as part of a word.

	-----------------------------
	-- History
	-----------------------------
	history = 1000, -- Maximum number of entries in the command-line history.

	-----------------------------
	-- Fill characters
	-----------------------------
	fillchars = {
		eob = " ", -- Hide ~ at end of buffer
		vert = "│", -- Thin vertical separator
		horiz = "─", -- Thin horizontal separator
		horizup = "┴",
		horizdown = "┬",
		vertleft = "┤",
		vertright = "├",
		verthoriz = "┼",
	},

	-----------------------------
	-- Others
	-----------------------------
	conceallevel = 0, -- Don't hide any text.
	title = true, -- Set the window title.
	timeoutlen = 300, -- Time to wait for a mapped sequence to complete.
	updatetime = 100, -- Time to wait in milliseconds for writing swap file.
	shortmess = "tTOlnxficFo",
}

-- Apply all options
for key, value in pairs(options) do
	vim.opt[key] = value
end
