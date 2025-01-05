-- luacheck: globals vim

-- local map = vim.api.nvim_set_keymap
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

local mode = {
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
map(mode.normal, 'fn', ':tab sp<Return>', opts)

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
-- Memo

map(mode.normal, '<Leader>mn', ':MemoNew<CR>', opts)
map(mode.normal, '<Leader>ml', ':Telescope memo list<CR>', opts)
map(mode.normal, '<Leader>mg', ':Telescope memo live_grep<CR>', opts)


------------------------------
-- Cursor

-- Jump to the beginning of the line
map(mode.normal_visual, '<Left>', '^', opts)

-- Jump to the end of the line
map(mode.normal_visual, '<Right>', '$', opts)

-- Jump to the next page
map(mode.normal_visual, '<Down>', '<C-e>', opts)

-- Jump to the end of the line
map(mode.normal_visual, '<Up>', '<C-y>', opts)

-- Jump cursor to the begginning of the next paragraph
map(mode.normal_visual, '<S-j>', '}', opts)

-- Jump cursor to the end of the previous paragraph
map(mode.normal_visual, '<S-k>', '{', opts)


local function move_to_word_end_or_next()
  -- 現在のカーソル位置を取得
  local current_pos = vim.api.nvim_win_get_cursor(0)
  local line_num = current_pos[1]
  local column_num = current_pos[2]

  -- 現在の行を取得
  local line = vim.api.nvim_get_current_line()

  -- 現在の単語の末尾の位置を取得
  local current_word_end_pos = vim.fn.matchend(line, '\\k\\+', column_num)

  -- 次の単語の先頭の位置を取得
  local next_word_start_pos = vim.fn.match(line, '\\k', column_num + 1)

  -- 次の単語の先頭の位置が取得できない場合（次の単語が存在しない場合）、行末に移動
  if next_word_start_pos == -1 then
    vim.api.nvim_win_set_cursor(0, { line_num, #line })
    return
  end


  -- 単語の末尾にいる場合
  if current_word_end_pos - 1 == column_num then
    -- 次の単語の先頭に移動
    if next_word_start_pos ~= -1 then
      vim.api.nvim_win_set_cursor(0, { line_num, next_word_start_pos })
    end
    return
  end

  -- 現在の単語の末尾に移動
  vim.api.nvim_win_set_cursor(0, { line_num, current_word_end_pos - 1 })
end

-- Jump cursor to the beginning of the next word
-- vim.keymap.set('n', '<S-l>', function()
--   -- Check if the cursor is at the end of the line
--   local function is_cursor_at_line_end()
--     local cursor_pos = vim.api.nvim_win_get_cursor(0)
--     local line = vim.api.nvim_get_current_line()
--     local column = cursor_pos[2]
--     return column == #line - 1
--   end
--
--   if is_cursor_at_line_end() then
--     vim.cmd('normal! j0')
--   else
--     move_to_word_end_or_next()
--   end
-- end, opts)
map('n', '<S-l>', 'w', opts)

-- Jump cursor to the beginning of the previous word
map('n', '<S-h>', 'b', opts)


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
map(mode.normal, '<C-T>',
  '<cmd>FloatermNew --height=0.8 --width=0.8 --wintype=float --name=floaterm1 --position=center<CR>', opts)

-- Git
map(mode.normal, 'gh', ':Gitsigns preview_hunk<CR>', opts)
map(mode.normal, 'gj', ':Gitsigns next_hunk<CR>', opts)
map(mode.normal, 'gk', ':Gitsigns prev_hunk<CR>', opts)
map(mode.normal, '<Leader><Leader>', ':DiffviewOpen<CR>', opts)
map(mode.normal, '<Leader>c', ':DiffviewClose<CR>', opts)
