return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local icons = require("util.icons")
		local colors = _G.CustomColors

		-- Use auto theme and override with transparent highlights after setup
		require("lualine").setup({
			options = {
				icons_enabled = true,
				theme = "auto",
				section_separators = { left = "", right = "" },
				component_separators = { left = "", right = "" },
				disabled_filetypes = {
					statusline = { "NvimTree" },
				},
				draw_empty = false,
				globalstatus = true,
			},
			sections = {
				lualine_a = {},
				lualine_b = {
					{
						"branch",
						draw_empty = false,
						padding = { left = 1, right = 1 },
					},
					{
						"diff",
						colored = true,
						draw_empty = true,
						padding = { left = 0, right = 1 },
					},
				},
				lualine_c = {},
				lualine_x = {
					{
						"diagnostics",
						colored = true,
						sources = { "nvim_lsp" },
						symbols = {
							error = icons.diagnostic.error .. " ",
							warn = icons.diagnostic.warn,
							info = icons.diagnostic.info,
							hint = icons.diagnostic.hint,
						},
						always_visible = true,
						update_in_insert = true,
						padding = { left = 1, right = 2 },
					},
				},
				lualine_y = {
					{
						"filetype",
						colored = true,
						icon_only = false,
						icon = { align = "left" },
						padding = { left = 1, right = 1 },
					},
					{
						"encoding",
						show_bomb = true,
						padding = { left = 0, right = 1 },
					},
					{
						"fileformat",
						padding = { left = 0, right = 2 },
						symbols = {
							unix = "LF",
							dos = "CRLF",
							mac = "CR",
						},
					},
				},
				lualine_z = {},
			},
			tabline = {},
			extensions = {},
		})

		-- Function to make all lualine highlights transparent
		local function make_lualine_transparent()
			vim.api.nvim_set_hl(0, "StatusLine", { bg = "NONE" })
			vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "NONE" })

			-- Override ALL lualine highlight groups
			for name, hl in pairs(vim.api.nvim_get_hl(0, {})) do
				if name:match("^lualine") then
					vim.api.nvim_set_hl(0, name, { fg = hl.fg, bg = "NONE", bold = hl.bold, italic = hl.italic })
				end
			end
		end

		-- Apply after lualine creates its highlights
		vim.api.nvim_create_autocmd("ColorScheme", {
			callback = function()
				vim.defer_fn(make_lualine_transparent, 100)
			end,
		})

		-- Apply immediately after setup (with longer delay to ensure lualine is ready)
		vim.defer_fn(make_lualine_transparent, 200)

		-- Re-apply when entering buffer (lualine may recreate highlights)
		vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter" }, {
			callback = function()
				vim.schedule(make_lualine_transparent)
			end,
		})
	end,
}
