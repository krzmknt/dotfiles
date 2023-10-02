-----------------------------
-- Options

local options = {
  background = 'dark',
  backup = false,
  backupskip = { '/tmp/*', '/private/tmp/*' },
  clipboard = 'unnamedplus',
  cmdheight = 1,
  completeopt = { 'menuone', 'noselect' },
  conceallevel = 0,
  cursorline = true,
  encoding = 'utf-8',
  expandtab = true,
  fileencoding = 'utf-8',
  guifont = 'monospace:h17',
  hlsearch = true,
  ignorecase = true,
  iskeyword = vim.opt.iskeyword + { '-' }, -- Not to break words at dash
  mouse = 'a',
  number = true,
  numberwidth = 4,
  pumblend = 5,
  pumheight = 10,
  relativenumber = false,
  scrolloff = 8,
  shell = 'fish',
  shiftwidth = 2,
  shortmess = 'tTOlnxficFo',
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

  showmode = false,
  showtabline = 2,
  sidescrolloff = 8,
  signcolumn = 'yes',
  smartcase = true,
  smartindent = true,
  splitbelow = false,
  splitright = false,
  swapfile = false,
  tabstop = 2,
  termguicolors = true,
  timeoutlen = 300,
  title = true,
  undofile = true,
  updatetime = 300,
  wildoptions = 'pum',
  winblend = 0,
  wrap = false,
  writebackup = false,
  whichwrap = 'b,s,<,>,[,],h,l',
}

for key, value in pairs(options) do
  vim.opt[key] = value
end


-----------------------------
-- Theme

require('colorscheme')


-----------------------------
-- Keymaps

require('keymaps')


-----------------------------
-- Auto commands

-- Create/get autocommand group
local augroup = vim.api.nvim_create_augroup

-- Create autocommand
local autocmd = vim.api.nvim_create_autocmd

-- Initialize autocommands
vim.cmd('autocmd!')

-- Remove whitespace on save
autocmd('BufWritePre', {
	pattern = '*',
	command = ':%s/\\s\\+$//e',
})

-- Don't auto commenting new lines
autocmd('BufEnter', {
	pattern = '*',
	command = 'set fo-=c fo-=r fo-=o',
})

-- Restore cursor location when file is opened
autocmd({ 'BufReadPost' }, {
	pattern = { '*' },
	callback = function()
		vim.api.nvim_exec('silent! normal! g`"zv', false)
	end,
})



-----------------------------
-- Plugins
--

require('plugins')

package.path = package.path .. ";/Users/krzmknt/Workspace/procon/.config/nvim/procon-tools/lua/?.lua"
require('procon-tools')


