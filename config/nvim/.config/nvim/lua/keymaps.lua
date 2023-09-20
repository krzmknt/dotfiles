--[[
Keymaps
]]

local map = vim.api.nvim_set_keymap
local opts = {noremap = true, silent = true}

mode = {
  normal = 'n',
  insert = 'i',
  visual = 'v',
  normal_visual = '',
  visual_block = 'x',
  terminal = 't',
  command_line = 'c',
}

-----------------------------
-- Leader

-- Remap space as leader key
map(mode.normal_visual, '<Space>', '<Nop>', opts)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '


-----------------------------
-- General

-- Turn off highlight
map(mode.normal, '<Esc><Esc>', ':<C-u>set nohlsearch<Return>', opts)

-- Save
map(mode.normal, '<C-s>', ':w<Return>', opts)
map(mode.insert, '<C-s>', '<ESC>:w<Return>', opts)
map(mode.visual, '<C-s>', '<ESC>:w<Return>', opts)

-- Increment/Decrement
map(mode.normal, '+', '<C-a>', opts)
map(mode.normal, '-', '<C-x>', opts)

-- Select al
map(mode.normal_visual, '<C-a>', 'gg<S-v>G', opts)

-- Do not yank with x
map(mode.normal, 'x', '"_x', opts)

-- Insert a space after ,
map(mode.insert, ',', ',<Space>', opts)

-- Delete the word
map(mode.normal, '<C-d>', 'bcw', opts)
map(mode.insert, '<C-d>', '<ESC>bcw', opts)


-----------------------------
-- Tab

-- New
map(mode.normal, 'fn', ':tabnew<Return>', opts)

-- Move
map(mode.normal, 'fl', ':tabnext<Return>', opts)
map(mode.normal, 'fh', ':tabprevious<Return>', opts)


------------------------------
-- File

-- Go definition
map(mode.normal, 'gd', ":call CocAction('jumpDefinition', 'tab drop')<Return>", opts)


------------------------------
-- Window

-- Split horizontally
map(mode.normal, 'ss', ':split<Return><C-w>w', opts)

-- Split vertically
map(mode.normal, 'sv', ':vsplit<Return><C-w>w', opts)

-- Close
map(mode.normal, '<Leader>x', ':x!<Return>', opts)
map(mode.normal, '<Leader>q', ':q!<Return>', opts)

-- Move
map(mode.normal, '<C-h>', '<C-w>h', opts)
map(mode.normal, '<C-j>', '<C-w>j', opts)
map(mode.normal, '<C-k>', '<C-w>k', opts)
map(mode.normal, '<C-l>', '<C-w>l', opts)


------------------------------
-- Cursor

-- Jump to the beginning of the line
map(mode.normal_visual, '<S-h>', '^', opts)

-- Jump to the end of the line
map(mode.normal_visual, '<S-l>', '$', opts)

-- Jump cursor to the end of the paragraph
map(mode.normal_visual, '<S-j>', '}', opts)

-- Jump cursor to the beginning of the paragraph
map(mode.normal_visual, '<S-k>', '{', opts)


-----------------------------
-- Launcher

-- DAP
map(mode.normal, '<leader>d', ':lua require("dapui").toggle()<CR>', {})
map(mode.normal, '<leader>b', ':DapToggleBreakpoint<CR>', opts)

-- Telescope
map(mode.normal, '<Leader>f', '<cmd>Telescope find_files<cr>', opts)
map(mode.normal, '<Leader>v', '<cmd>Telescope file_browser<cr>', opts)
map(mode.normal, '<Leader>g', '<cmd>Telescope live_grep<cr>', opts)

-- Floaterm
map(mode.normal, '<C-T>', '<cmd>FloatermNew --height=0.8 --width=0.8 --wintype=float --name=floaterm1 --position=center<CR>', opts)

-- Procon
map(mode.normal, '<Leader>at', '<cmd>ProconTest<CR>', opts)
map(mode.normal, '<Leader>as', '<cmd>ProconSubmit<CR>', opts)
