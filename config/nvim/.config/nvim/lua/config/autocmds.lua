-----------------------------
-- Autocommands Configuration
-----------------------------

-- Configure auto commands
local function configureAutocommands()
	-- Create autocommand
	local autocmd = vim.api.nvim_create_autocmd

	-- Initialize autocommands (clear all existing autocommands)
	vim.cmd("autocmd!")

	-- Removes trailing whitespace on save
	autocmd("BufWritePre", {
		pattern = { "*" },
		command = ":%s/\\s\\+$//e",
	})

	-- Disable auto-commenting new lines
	autocmd("BufEnter", {
		pattern = { "*" },
		command = "set fo-=c fo-=r fo-=o",
	})

	-- Restore cursor to last position when reopening a file
	autocmd({ "BufReadPost" }, {
		pattern = { "*" },
		callback = function()
			vim.cmd('silent! normal! g`"zv')
		end,
	})

	-- Set file type specific options
	autocmd("FileType", {
		pattern = { "java" },
		callback = function()
			vim.bo.shiftwidth = 4
			vim.bo.tabstop = 4
			vim.bo.expandtab = true
		end,
	})

	autocmd("FileType", {
		pattern = { "markdown" },
		callback = function()
			vim.bo.shiftwidth = 2
			vim.bo.tabstop = 2
			vim.bo.expandtab = true
		end,
	})
end

configureAutocommands()
