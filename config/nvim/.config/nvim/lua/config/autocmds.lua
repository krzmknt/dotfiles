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

	-- Scan project files for diagnostics on startup
	-- This loads files in background to trigger LSP analysis
	autocmd("VimEnter", {
		callback = function()
			vim.defer_fn(function()
				-- Get project files (limit to common source files)
				local patterns = { "*.ts", "*.tsx", "*.js", "*.jsx", "*.lua", "*.py" }
				local files = {}

				for _, pattern in ipairs(patterns) do
					local found = vim.fn.glob(vim.fn.getcwd() .. "/**/" .. pattern, false, true)
					for _, f in ipairs(found) do
						-- Skip node_modules and other common directories
						if not f:match("node_modules") and not f:match("%.git") and not f:match("dist/") then
							table.insert(files, f)
						end
					end
				end

				-- Limit to first 50 files to avoid performance issues
				local max_files = 50
				for i = 1, math.min(#files, max_files) do
					-- Open file in background buffer (hidden)
					local bufnr = vim.fn.bufadd(files[i])
					vim.fn.bufload(bufnr)
				end

				-- Refresh NvimTree after LSP has time to analyze
				vim.defer_fn(function()
					local ok, api = pcall(require, "nvim-tree.api")
					if ok then
						api.tree.reload()
					end
				end, 2000)
			end, 500)
		end,
	})
end

configureAutocommands()
