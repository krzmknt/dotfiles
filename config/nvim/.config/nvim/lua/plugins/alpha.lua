return {
	"goolord/alpha-nvim",
	event = "VimEnter",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")
		local colors = require("util.color")

		-- Set pink color for header
		vim.api.nvim_set_hl(0, "AlphaHeader", { fg = colors.pink, bold = true })

		-- ASCII art header
		dashboard.section.header.val = {
			"                                                     ",
			"  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
			"  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
			"  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
			"  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
			"  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
			"  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
			"                                                     ",
		}
		dashboard.section.header.opts.hl = "AlphaHeader"

		-- Recent files section
		local function get_recent_files()
			local oldfiles = vim.v.oldfiles
			local max_shown = 15
			local recent = {}

			for i, file in ipairs(oldfiles) do
				if #recent >= max_shown then
					break
				end
				-- Only show files that exist and are not in special directories
				if vim.fn.filereadable(file) == 1 and not string.match(file, "COMMIT_EDITMSG") then
					table.insert(recent, file)
				end
			end

			return recent
		end

		local recent_files = {
			type = "group",
			val = function()
				local header = {
					type = "text",
					val = "Recent Files (press r for more)",
					opts = { hl = "SpecialComment", position = "center" },
				}
				local oldfiles = get_recent_files()
				local file_buttons = {}

				-- Get window width for truncation
				local win_width = vim.api.nvim_win_get_width(0)
				local max_path_length = math.max(40, win_width - 20) -- Reserve some space for padding

				for i, file in ipairs(oldfiles) do
					-- Display full path relative to home directory
					local display_path = vim.fn.fnamemodify(file, ":~")

					-- Truncate from the left if path is too long
					if #display_path > max_path_length then
						local filename = vim.fn.fnamemodify(file, ":t")
						local available_space = max_path_length - #filename - 4 -- Reserve space for ".../" and filename
						if available_space > 0 then
							local path_start = #display_path - max_path_length + 4
							display_path = "..." .. string.sub(display_path, path_start)
						else
							-- If even filename is too long, just show the filename truncated
							display_path = "..." .. string.sub(filename, -(max_path_length - 3))
						end
					end

					local display_text = string.format("%s", display_path)

					-- Create clickable button for each recent file
					local button =
						dashboard.button(tostring(i), display_text, ":e " .. vim.fn.fnameescape(file) .. "<CR>")
					button.opts.hl = "Comment"
					button.opts.hl_shortcut = "Comment"
					button.opts.shortcut = "" -- Hide number shortcut
					button.opts.cursor = -2 -- Position cursor on the left
					button.opts.align_shortcut = "left"
					button.opts.width = 50
					table.insert(file_buttons, button)
				end

				if #file_buttons == 0 then
					table.insert(file_buttons, { type = "text", val = "  No recent files", opts = { hl = "Comment" } })
				end

				return { header, { type = "padding", val = 1 }, unpack(file_buttons) }
			end,
		}

		-- Menu buttons
		local function make_menu_button(sc, text, command)
			local btn = dashboard.button(sc, text, command)
			btn.opts.shortcut = sc .. "    " -- Add 4 spaces after shortcut key
			return btn
		end

		dashboard.section.buttons.val = {
			make_menu_button(
				"f",
				"     Find file",
				":lua require('telescope.builtin').find_files({hidden=true, no_ignore=false, file_ignore_patterns={'^%.git/', '%.git/'}})<CR>"
			),
			make_menu_button("g", "     Find text", ":Telescope live_grep<CR>"),
			make_menu_button("b", "     File browser", ":Telescope file_browser<CR>"),
			make_menu_button("q", "     Quit", ":qa<CR>"),
		}
		dashboard.section.buttons.opts = {
			spacing = 0, -- Remove spacing between buttons
		}

		-- Footer
		local function footer()
			local total_plugins = #vim.tbl_keys(require("lazy").plugins())
			local datetime = os.date(" %Y-%m-%d   %H:%M:%S")
			local version = vim.version()
			local nvim_version_info = "   v" .. version.major .. "." .. version.minor .. "." .. version.patch

			return datetime .. "   " .. total_plugins .. " plugins" .. nvim_version_info
		end

		dashboard.section.footer.val = footer()

		-- Layout
		dashboard.config.layout = {
			{ type = "padding", val = 2 },
			dashboard.section.header,
			{ type = "padding", val = 0 },
			dashboard.section.footer,
			{ type = "padding", val = 2 },
			recent_files,
			{ type = "padding", val = 2 },
			dashboard.section.buttons,
		}

		-- Set cursorline highlight for alpha with yellow text
		vim.api.nvim_set_hl(0, "AlphaCursorLine", { fg = colors.yellow, bold = true, bg = colors.none })

		local alpha_hl_ns = vim.api.nvim_create_namespace("alpha_highlight")

		local function highlight_alpha_cursor_line()
			local bufnr = vim.api.nvim_get_current_buf()
			if vim.bo[bufnr].filetype ~= "alpha" then
				return
			end

			-- Clear previous highlights
			vim.api.nvim_buf_clear_namespace(bufnr, alpha_hl_ns, 0, -1)

			-- Get current line
			local line = vim.fn.line(".") - 1
			local line_text = vim.api.nvim_buf_get_lines(bufnr, line, line + 1, false)[1] or ""

			-- Highlight entire line in yellow
			if line_text ~= "" then
				vim.api.nvim_buf_add_highlight(bufnr, alpha_hl_ns, "AlphaCursorLine", line, 0, -1)
			end
		end

		vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI", "BufEnter", "WinEnter" }, {
			callback = function()
				vim.schedule(highlight_alpha_cursor_line)
			end,
		})

		vim.api.nvim_create_autocmd("FileType", {
			pattern = "alpha",
			callback = function()
				-- Initial highlight
				vim.schedule(function()
					vim.schedule(highlight_alpha_cursor_line)
				end)
				-- Hide cursor in alpha buffer
				vim.opt_local.guicursor = "a:Cursor/lCursor"
				vim.api.nvim_set_hl(0, "Cursor", { blend = 100 })
				vim.api.nvim_set_hl(0, "lCursor", { blend = 100 })
			end,
		})

		-- Restore cursor when leaving alpha buffer
		vim.api.nvim_create_autocmd("BufLeave", {
			pattern = "*",
			callback = function()
				if vim.bo.filetype == "alpha" then
					vim.api.nvim_set_hl(0, "Cursor", { fg = colors.none, bg = colors.purple })
					vim.api.nvim_set_hl(0, "lCursor", { fg = colors.none, bg = colors.purple })
				end
			end,
		})

		alpha.setup(dashboard.config)
	end,
}
