-----------------------------
-- Options
--

--- Configure global options.
-- Add the directory containing the procon-tools.lua file to the package path.
-- This is necessary to load the procon-tools module.
local function configureOptions()
  local options = {

    -----------------------------
    -- Mode
    --
    showmode      = false, -- Use true colors in the terminal.

    -----------------------------
    -- Color
    --
    termguicolors = true, -- Use true colors in the terminal.

    -----------------------------
    -- Pop-up menu / Floating window
    --
    pumblend      = 20, -- Popup menu transparency.
    pumheight     = 20, -- Popup menu height.
    winblend      = 0,  -- Floating window transparency.


    -----------------------------
    -- Cursor
    --
    cursorline    = true,                 -- Highlight the current line.
    cursorcolumn  = true,                 -- Highlight the current column.
    cursorlineopt = { 'line', 'number' }, -- Highlight the current line and number.
    scrolloff     = 10,                   -- Minumum number of lines to keep above and below the cursor.
    sidescrolloff = 10,                   -- Minimum number of columns to keep to the left and right of the cursor.


    -----------------------------
    -- Mouse
    --
    mouse       = 'a',           -- Enable mouse support for all modes.
    mousehide   = true,          -- Hide the mouse pointer while typing.
    mousemodel  = 'extend',      -- Use right mouse button to extend selection.
    mousescroll = 'ver:1,hor:1', -- the number of lines / columns to scroll by when scrolling with a mouse wheel.


    -----------------------------
    -- Command line
    --
    cmdheight    = 1,     -- Command line height.
    cmdwinheight = 7,     -- Command window height.
    wildoptions  = 'pum', -- Show the popup menu when pressing <Tab> in the command-line.


    -----------------------------
    -- Completion
    --
    completeopt = { 'menuone', 'noselect' }, -- COC と関連する？

    --- Indicates the type of completion and the places to scan.
    -- .      : scan the current buffer ('wrapscan' is ignored)
    -- w      : scan buffers from other windows
    -- b      : scan other loaded buffers that are in the buffer list
    -- u      : scan the unloaded buffers that are in the buffer list
    -- U      : scan the buffers that are not in the buffer list
    -- k      : scan the files given with the 'dictionary' option
    -- kspell :use the currently active spell checking spell
    -- k{dict}:scan the file {dict}.  Several "k" flags can be given, patterns are valid too.
    -- s      : scan the files given with the 'thesaurus' option
    -- s{tsr} : scan the file {tsr}.  Several "s" flags can be given, patterns are valid too.
    -- i      : scan current and included files
    -- d      : scan current and included files for defined name or macro i_CTRL-X_CTRL-D
    -- ]      : tag completion
    -- t      : same as "]"
    -- f      : scan the buffer names (as opposed to buffer contents)
    -- @see https://neovim.io/doc/user/options.html#'complete'
    complete    = { '.', 'w', 'b', 'u', 't' },


    -----------------------------
    -- Wrap
    --
    wrap        = true,              -- Line wrapping.
    linebreak   = true,              -- Wrap long lines at a character in 'breakat' rather than at the last character that fits on the screen.
    breakat     = " ^I!@*-+;:,./?",  -- This option lets you choose which characters might cause a line break if 'linebreak' is on.  Only works for ASCII characters.
    breakindent = true,              -- Every wrapped line will continue visually indented (same amount of space as the beginning of that line), thus preserving horizontal blocks of text.
    wrapmargin  = 1,                 -- Number of columns from the right window border where wrapping starts.
    whichwrap   = 'b,s,<,>,[,],h,l', -- Allow certain movements to wrap around lines.


    -----------------------------
    -- Fold
    --
    foldenable   = true,     -- Whether folding is enabled.
    foldmethod   = 'syntax', -- Folding method.
    foldcolumn   = 'auto',   -- When and how to draw the foldcolumn.
    foldlevel    = 0,        -- Folds with a higher level will be closed.
    foldnestmax  = 10,       -- The maximum nesting of folds for the "indent" and "syntax" methods.
    foldminlines = 10,       -- The minimum number of lines for a fold.
    foldopen     = {         -- The method to use for opening a fold.
      'block',
      'hor',
      'insert',
      'jump',
      'mark',
      'percent',
      'quickfix',
      'search',
      'tag',
      'undo'
    },
    foldclose    = 'all', -- Close all folds when the cursor moves out of them.
    foldignore   = '#/',  -- Don't ignore any folds.


    -----------------------------
    -- Sign Column
    --
    signcolumn = 'auto', -- Always show the sign column.


    -----------------------------
    -- Number column
    --
    number         = true, -- Show line numbers.
    numberwidth    = 4,    -- Line number column width.
    relativenumber = true, -- Show relative line numbers.


    -----------------------------
    -- Clipboard
    --
    clipboard = 'unnamedplus', -- Use the system clipboard.


    -----------------------------
    -- Indentation
    --
    expandtab   = true, -- Use spaces instead of tabs.
    smartindent = true, -- Smart indentation.
    shiftwidth  = 2,    -- Identation width for >>, <<, etc.
    tabstop     = 2,    -- Number of spaces that a <Tab> in the file counts for.
    showtabline = 2,    -- Always show the tabline.


    -----------------------------
    -- Search and Replace
    --
    hlsearch   = true, -- Highlight search results.
    ignorecase = true, -- Ignore case when searching.
    smartcase  = true, -- Override 'ignorecase' if the search pattern contains upper case characters.
    incsearch  = true, -- Incremental search.


    -----------------------------
    -- Backup
    --
    backup      = false,                          -- Disable backup files.
    backupskip  = { '/tmp/*', '/private/tmp/*' }, -- Skip backups for temporary files.
    swapfile    = false,                          -- Disable swap files.
    undofile    = true,                           -- Enable persistent undo.
    writebackup = false,                          -- Disable backup files.


    -----------------------------
    -- Encoding and File format
    --
    encoding      = 'utf-8',     -- String-encoding used internally and for RPC communication.
    fileencoding  = 'utf-8',     -- File encoding.
    fileencodings = { 'utf-8' }, -- List of file encodings to try when starting to edit an existing file.
    fileformat    = 'unix',      -- <NL>
    fileformats   = { 'unix' },  -- Permitted value is

    -----------------------------
    -- Terminal
    --
    shell         = 'fish', -- Default shell.

    -----------------------------
    -- Window
    --
    splitbelow    = true, -- When on, splitting a window will put the new window below the current one.
    splitright    = true, -- When on, splitting a window will put the new window right of the current one.

    -----------------------------
    -- Word
    --
    iskeyword     = "@,48-57,_,192-255,-", -- Treat dash as part of a word.

    -----------------------------
    -- History
    --
    history       = 1000, -- Maximum number of entries in the command-line history.

    -----------------------------
    -- Others
    --
    conceallevel  = 0,    -- Don't hide any text.
    title         = true, -- Set the window title.
    timeoutlen    = 300,  -- Time to wait for a mapped sequence to complete.
    updatetime    = 300,  -- Time to wait in milliseconds for writing swap file.

    --- Shortmess options:
    -- t: Truncate long messages.
    -- T: Eliminate the message when an included tag file can't be opened.
    -- O: Overwrite the "File exists" message when writing a file.
    -- l: Eliminate "search hit BOTTOM, continuing at TOP" for the 'wrapscan' option.
    -- n: Eliminate the line number from the ":next" or ":prev" message.
    -- x: Enable some extra abbreviations, such as "file read" to "read".
    -- f: Enable abbreviation for file messages, like "written" to "w".
    -- i: Eliminate "search hit BOTTOM, continuing at TOP" for 'wrapscan' option.
    -- c: Remove the initial message when entering the Command-line window.
    -- F: Disable the "(3 of 5): text" message for the :s command.
    -- o: Omit fileinfo message for :w command.
    shortmess     = 'tTOlnxficFo'
  }

  for key, value in pairs(options) do
    vim.opt[key] = value
  end
end
configureOptions()

-----------------------------
-- Autocommands

-- Markdown 記号の conceal 設定
vim.cmd [[
  autocmd FileType markdown syntax match markdownListMarker /^\s*[-*]\s/ conceal cchar=✦
  autocmd FileType markdown setlocal conceallevel=2
]]

-----------------------------
-- Global Variables


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

local colors = require('onedark.colors')
-- :lua print(vim.inspect(require('onedark.colors')))
--
-- colors.black
-- colors.blue
-- colors.cyan d
-- colors.grey
-- colors.green
-- colors.light_grey
-- colors.orange
-- colors.purple d
-- colors.red d
-- colors.yellow d

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

-----------------------------
-- Keymaps
--
-- Define custom key mappings.
--

require('keymaps')


-----------------------------
-- Aliases
--

vim.api.nvim_create_user_command('Do', 'DiffviewOpen <args>', { nargs = '*' })
vim.api.nvim_create_user_command('Dc', 'DiffviewClose <args>', { nargs = '*' })


-----------------------------
-- Auto commands
--
-- Autocommands are used to execute commands automatically when certain events occur.
--

--- Configure auto commands.
local function configureAutocommands()
  -- Create/get autocommand group
  -- local augroup = vim.api.nvim_create_augroup

  -- Create autocommand
  local autocmd = vim.api.nvim_create_autocmd

  -- Initialize autocommands (clear all existing autocommands)
  vim.cmd('autocmd!')

  -- Remove whitespace on save
  autocmd('BufWritePre', {
    pattern = { '*' },
    command = ':%s/\\s\\+$//e',
  })

  -- Don't auto commenting new lines
  autocmd('BufEnter', {
    pattern = { '*' },
    command = 'set fo-=c fo-=r fo-=o',
  })

  -- Restore cursor location when file is opened
  autocmd({ 'BufReadPost' }, {
    pattern = { '*' },
    callback = function()
      vim.api.nvim_exec('silent! normal! g`"zv', false)
    end,
  })

  -- Set file type specific options
  autocmd("FileType", {
    pattern = { "java" },
    callback = function()
      vim.bo.shiftwidth = 4
      vim.bo.tabstop = 4
      vim.bo.expandtab = true
    end
  })
end
configureAutocommands()


-----------------------------
-- Plugins
--

require('plugins')


-----------------------------
-- memo
vim.g.memolist_path = vim.fn.expand("~/.memolist/memo")
vim.g.memolist_memo_suffix = "md"
vim.g.memolist_fzf = 1
vim.g.memolist_template_dir_path = vim.fn.expand("~/.memolist/memotemplates")
