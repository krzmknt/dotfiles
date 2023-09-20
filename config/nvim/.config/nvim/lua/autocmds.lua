-- Create/get autocommand group
local augroup = vim.api.nvim_create_augroup

-- Create autocommand
local autocmd = vim.api.nvim_create_autocmd

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
