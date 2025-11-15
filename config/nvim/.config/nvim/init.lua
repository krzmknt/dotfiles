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
    foldenable   = false,    -- Whether folding is enabled.
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
    signcolumn = 'yes', -- Always show the sign column.


    -----------------------------
    -- Number column
    --
    number         = true, -- Show line numbers.
    numberwidth    = 1,    -- Minimum width (auto-expands as needed).
    relativenumber = true, -- Show relative line numbers.
    statuscolumn   = "%s%=%{v:relnum?v:relnum:v:lnum} ", -- Show signs (left) and right-align line numbers.


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
    updatetime    = 100,  -- Time to wait in milliseconds for writing swap file.

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
-- Show column number at the end of current line
--

local col_ns = vim.api.nvim_create_namespace('column_display')

local function show_column_number()
  -- Clear previous virtual text
  vim.api.nvim_buf_clear_namespace(0, col_ns, 0, -1)

  -- Get current position
  local line = vim.fn.line('.') - 1  -- 0-indexed
  local col = vim.fn.col('.')

  -- Get window width
  local win_width = vim.api.nvim_win_get_width(0)

  -- Calculate position (right edge, accounting for scrollbar)
  local col_text = string.format('[%d]', col)
  local pos = win_width - #col_text - 6  -- 6 chars padding to avoid scrollbar

  -- Add virtual text at the right edge of window
  vim.api.nvim_buf_set_extmark(0, col_ns, line, 0, {
    virt_text = {{ col_text, 'LineNr' }},  -- Use LineNr highlight (not italic)
    virt_text_win_col = pos,  -- Position at right edge
  })
end

-- Update on cursor move
vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
  callback = show_column_number,
})


-----------------------------
-- Plugins
--

require("config.lazy")


-----------------------------
-- Color
--
require('color')



-----------------------------
-- memo
vim.g.memolist_path              = vim.fn.expand("~/.memolist/memo")
vim.g.memolist_memo_suffix       = "md"
vim.g.memolist_fzf               = 1
vim.g.memolist_template_dir_path = vim.fn.expand("~/.memolist/memotemplates")

-----------------------------
-- NERDCommenter
vim.g.NERDSpaceDelims            = 1
vim.g.NERDDefaultAlign           = "left"

-----------------------------
-- Tab label configuration
-- Fancy tabline with icons, colors, and indicators

function _G.get_file_icon(filename)
  -- Get devicons if available
  local has_devicons, devicons = pcall(require, 'nvim-web-devicons')
  if has_devicons and filename ~= '' then
    local icon, icon_color = devicons.get_icon(filename, vim.fn.fnamemodify(filename, ':e'), { default = true })
    return icon or '', icon_color
  end
  return '', nil
end

function _G.custom_tablabel(n)
  local buflist = vim.fn.tabpagebuflist(n)
  local winnr = vim.fn.tabpagewinnr(n)
  local bufnr = buflist[winnr]
  local filepath = vim.fn.bufname(bufnr)
  local is_modified = vim.fn.getbufvar(bufnr, "&modified") == 1

  -- Get filename
  local filename = ''
  if filepath == '' then
    filename = '[No Name]'
  else
    filename = vim.fn.fnamemodify(filepath, ':t')

    -- Shorten path (3 chars per directory)
    local parts = vim.split(filepath, '/')
    local path_parts = {}
    for i = 1, #parts - 1 do
      local part = parts[i]
      if #part > 3 then
        table.insert(path_parts, string.sub(part, 1, 3))
      else
        table.insert(path_parts, part)
      end
    end

    if #path_parts > 0 then
      filename = table.concat(path_parts, '/') .. '/' .. filename
    end
  end

  -- Get file icon
  local icon, _ = _G.get_file_icon(vim.fn.fnamemodify(filepath, ':t'))

  -- Build label with icon, filename, and modified indicator
  local label = string.format(' %s %s%s ',
    icon ~= '' and icon or '',           -- File icon
    filename,                             -- Filename with path
    is_modified and ' ●' or ''           -- Modified indicator
  )

  return label
end

function _G.custom_tabline()
  local s = ''
  local current_tab = vim.fn.tabpagenr()

  for i = 1, vim.fn.tabpagenr('$') do
    -- Select highlighting
    if i == current_tab then
      s = s .. '%#TabLineSel#'
    else
      s = s .. '%#TabLine#'
    end

    -- Set the tab page number (for mouse clicks)
    s = s .. '%' .. i .. 'T'

    -- Get the label
    s = s .. _G.custom_tablabel(i)

    -- Add separator between tabs
    if i < vim.fn.tabpagenr('$') then
      s = s .. '%#TabLine#│'
    end
  end

  -- After the last tab fill with TabLineFill and reset tab page number
  s = s .. '%#TabLineFill#%T'

  return s
end

vim.o.tabline = '%!v:lua.custom_tabline()'
