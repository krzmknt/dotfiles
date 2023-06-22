local opts = { noremap = true, silent = true }
local term_opts = { silent = true }
local keymap = vim.api.nvim_set_keymap

-- Remap space as leader key
keymap('', '<Space>', '<Nop>', opts)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '



-- ==============================================
-- Cheetsheet
-- ----------------------------------------------
-- Modes
--   normal_mode = 'n',
--   insert_mode = 'i',
--   visual_mode = 'v',
--   visual_block_mode = 'x',
--   term_mode = 't',
--   command_mode = 'c',


-- ==============================================
-- Normal
-- ----------------------------------------------

-- ----------------------------------------------
-- General
-- ----------------------------------------------
-- ;でコマンド入力( ;と:を入れ替え)
keymap('n', ';', ':', opts)

-- 行末までのヤンクにする
keymap('n', 'Y', 'y$', opts)

-- <Space>q で強制終了
keymap('n', '<Space>q', ':<C-u>q!<Return>', opts)

-- ESC*2 でハイライトやめる
keymap('n', '<Esc><Esc>', ':<C-u>set nohlsearch<Return>', opts)

-- Telescope
keymap('n', '<Leader>f', '<cmd>Telescope find_files<cr>', opts)
keymap('n', '<Leader>v', '<cmd>Telescope file_browser<cr>', opts)
keymap('n', '<Leader>g', '<cmd>Telescope live_grep<cr>', opts)

-- Save
keymap('n', '<C-s>', ':w<Return>', opts)


-- Increment/Decrement
keymap('n', '+', '<C-a>', opts)
keymap('n', '-', '<C-x>', opts)

-- Select all
keymap('n', '<C-a>', 'gg<S-v>G', opts)

-- Do not yank with x
keymap('n', 'x', '"_x', opts)

-- Delete a word backwards
keymap('n', 'dw', 'vb"_d', opts)


-- ----------------------------------------------
-- Tab
-- ----------------------------------------------
-- New tab
keymap('n', 'fe', ':tabedit ', opts)
keymap('n', 'fn', ':tabnew<Return>', opts)

-- Close
keymap('n', 'fw', ':tabclose<Return>', opts)

-- Move
keymap('n', 'fl', ':tabnext<Return>', opts)
keymap('n', 'fh', ':tabprevious<Return>', opts)


-- ----------------------------------------------
-- Window
-- ----------------------------------------------
-- Split horizontally
keymap('n', 'ss', ':split<Return><C-w>w', opts)

-- Split vertically
keymap('n', 'sv', ':vsplit<Return><C-w>w', opts)

-- Close
keymap('n', '<Leader>x', ':x!<Return>', opts)
keymap('n', '<Leader>q', ':q!<Return>', opts)

-- Move
keymap('n', '<C-h>', '<C-w>h', opts)
keymap('n', '<C-j>', '<C-w>j', opts)
keymap('n', '<C-k>', '<C-w>k', opts)
keymap('n', '<C-l>', '<C-w>l', opts)

-- Resize
keymap('n', '<C-w><C-H>', '3<C-W><', opts)
keymap('n', '<C-w><C-L>', '3<C-W>>', opts)
keymap('n', '<C-w><C-J>', '3<C-W>+', opts)
keymap('n', '<C-w><C-K>', '3<C-W>-', opts)

-- Delete the word
keymap('n', '<C-d>', 'bcw', opts)
keymap('i', '<C-d>', '<ESC>bcw', opts)

-- ----------------------------------------------
-- Cursor
-- ----------------------------------------------
-- Beggining of the line
keymap('n', '<Space>h', '^', opts)

-- End of the line
keymap('n', '<Space>l', '$', opts)

-- Paragraph
keymap('n', '<S-j>', '}', opts)
keymap('n', '<S-k>', '{', opts)
keymap('v', '<S-j>', '}', opts)
keymap('v', '<S-k>', '{', opts)

-- Page
keymap('n', '}', '<C-F>', opts)
keymap('n', '{', '<C-B>', opts)

-- Unix Like
keymap('n', '<C-f>', '<Right>', opts)
keymap('n', '<C-b>', '<Left>', opts)

-- {number}G : {number}-th line
-- H         : Move to the high position of the window
-- M         : Move to the middle position of the window
-- L         : Move to the low position of the window


-- ----------------------------------------------
-- LSP
-- ----------------------------------------------
-- keymap('n', 'K',  '<cmd>lua vim.lsp.buf.hover()<CR>',opts)
-- keymap('n', 'gf', '<cmd>lua vim.lsp.buf.formatting()<CR>',opts)
-- keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>',opts)
-- keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>',opts)
-- keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>',opts)
-- keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>',opts)
-- keymap('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>',opts)
-- keymap('n', 'gn', '<cmd>lua vim.lsp.buf.rename()<CR>',opts)
-- keymap('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<CR>',opts)
-- keymap('n', 'ge', '<cmd>lua vim.diagnostic.open_float()<CR>',opts)
-- keymap('n', 'g]', '<cmd>lua vim.diagnostic.goto_next()<CR>',opts)
-- keymap('n', 'g[', '<cmd>lua vim.diagnostic.goto_prev()<CR>',opts)


-- ----------------------------------------------
-- FineCmdline
-- ----------------------------------------------
-- keymap('n', '<CR>',  '<cmd>FineCmdline<CR>', opts)


-- ----------------------------------------------
-- Floaterm
-- ----------------------------------------------
keymap('n', '<C-T>', '<cmd>FloatermNew --height=0.8 --width=0.8 --wintype=float --name=floaterm1 --position=center<CR>',
  opts)


-- ----------------------------------------------
-- programming contest
-- ----------------------------------------------

-- python
keymap(
  'n',
  '<Leader>p',
  '<cmd>FloatermNew --height=0.9 --width=0.8 --wintype=float --name=python --position=center ipython<CR>',
  opts
)

-- oj test
keymap(
  'n',
  '<Leader>at',
  '<cmd>FloatermNew --autoclose=0 --height=0.9 --width=0.8 --wintype=float --name=programming_contest --title=test --position=center t %:h<CR>',
  opts
)

-- acc submit
keymap(
  'n',
  '<Leader>as',
  '<cmd>FloatermNew --autoclose=1 --height=0.9 --width=0.8 --wintype=float --name=programming_contest --title=submit --position=center s %:h<CR>',
  opts
)

-- ==============================================
-- Insert
-- ----------------------------------------------
-- Exit insert mode and save
keymap('i', '<C-s>', '<ESC>:w<Return>', opts)
-- Insert a space after ,
keymap('i', ',', ',<Space>', opts)


-- ----------------------------------------------
-- Cursor
-- ----------------------------------------------
-- keymap('i', '<C-p>', '<Up>', opts)
-- keymap('i', '<C-n>', '<Down>', opts)
keymap('i', '<C-b>', '<Left>', opts)
keymap('i', '<C-f>', '<Right>', opts)

keymap('i', '<C-E>', '<ESC>$i', opts)
keymap('i', '<C-A>', '<ESC>^i', opts)


-- ==============================================
-- Visual
-- ----------------------------------------------
-- Stay in indent mode
keymap('v', '<', '<gv', opts)
keymap('v', '>', '>gv', opts)

-- ビジュアルモード時vで行末まで選択
keymap('v', 'v', '$h', opts)

-- 0番レジスタを使いやすくした
keymap('v', '<C-p>', '"0p', opts)


vim.cmd([[imap <silent><expr> <C-l> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-l>']])
vim.cmd([[smap <silent><expr> <C-l> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-l>']])



-- ==============================================
-- DAP
-- ----------------------------------------------
keymap('n', '<leader>d', ':lua require("dapui").toggle()<CR>', {})
keymap('n', '<leader>b', ':DapToggleBreakpoint<CR>', opts)



-- ==============================================
-- Fern
-- ----------------------------------------------
keymap('n', '<leader>a', ':Fern . -reveal=% -drawer -toggle -width=30<CR>', {})
