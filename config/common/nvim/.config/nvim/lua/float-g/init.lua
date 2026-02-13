local M = {}

M.config = {
	cmd = "g",
	width_ratio = 0.95,
	height_ratio = 0.95,
	border = "rounded",
}

function M.setup(opts)
	M.config = vim.tbl_deep_extend("force", M.config, opts or {})
end

function M.open()
	-- バッファ作成
	local buf = vim.api.nvim_create_buf(false, true)

	-- ウィンドウサイズ計算
	local width = math.floor(vim.o.columns * M.config.width_ratio)
	local height = math.floor(vim.o.lines * M.config.height_ratio)
	local row = math.floor((vim.o.lines - height) / 2)
	local col = math.floor((vim.o.columns - width) / 2)

	-- フローティングウィンドウ作成
	local win = vim.api.nvim_open_win(buf, true, {
		relative = "editor",
		width = width,
		height = height,
		row = row,
		col = col,
		style = "minimal",
		border = M.config.border,
	})

	-- 背景透過
	vim.api.nvim_set_option_value("winblend", 0, { win = win })
	vim.api.nvim_set_hl(0, "FloatGNormal", { bg = "NONE" })
	vim.api.nvim_set_hl(0, "FloatGBorder", { bg = "NONE" })
	vim.api.nvim_win_set_option(win, "winhighlight", "Normal:FloatGNormal,FloatBorder:FloatGBorder")

	-- ターミナル起動
	vim.fn.termopen(M.config.cmd, {
		on_exit = function()
			if vim.api.nvim_win_is_valid(win) then
				vim.api.nvim_win_close(win, true)
			end
		end,
	})

	vim.cmd("startinsert")

	-- Escape でフローティングウィンドウを閉じる（バッファローカル）
	vim.keymap.set("t", "<Esc>", function()
		if vim.api.nvim_win_is_valid(win) then
			vim.api.nvim_win_close(win, true)
		end
	end, { buffer = buf, noremap = true, silent = true })
end

return M
