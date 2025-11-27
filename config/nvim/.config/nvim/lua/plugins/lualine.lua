return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local icons = require("util.icons")
		local colors = _G.CustomColors

		local theme = {
			normal = {
				a = { fg = colors.dark_cyan, bg = colors.black },
				b = { fg = colors.white, bg = colors.black },
				c = { fg = colors.white, bg = colors.black },
			},
			insert = { a = { fg = colors.yellow, bg = colors.black } },
			visual = { a = { fg = colors.red, bg = colors.black } },
			replace = { a = { fg = colors.red, bg = colors.black } },
			inactive = {
				a = { fg = colors.white, bg = colors.black },
				b = { fg = colors.white, bg = colors.black },
				c = { fg = colors.white, bg = colors.black },
			},
		}

		require("lualine").setup({
			options = {
				icons_enabled = true,
				theme = theme,
				section_separators = { left = "", right = "" },
				component_separators = { left = "", right = "" },
				disabled_filetypes = {},
				draw_empty = false,
			},
			sections = {
				lualine_a = {
					{
						"mode",
						fmt = function(mode)
							return " " .. icons.mode[mode] .. " "
						end,
						icons_enabled = true,
						separator = {
							left = "",
							right = "",
						},
						padding = { left = 1, right = 1 },
					},
				},
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
						separator = {
							left = " ",
							right = " ",
						},
					},
				},
				lualine_c = {},
				lualine_x = {
					{
						"diagnostics",
						colored = true,
						sources = { "nvim_lsp" },
						symbols = {
							error = icons.diagnostic.error,
							warn = icons.diagnostic.warn,
							info = icons.diagnostic.info,
							hint = icons.diagnostic.hint,
						},
						always_visible = true,
						update_in_insert = true,
					},
				},
				lualine_y = {
					{
						"filetype",
						colored = true,
						icon_only = false,
						icon = { align = "left" },
						separator = {
							left = "",
							right = "",
						},
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
	end,
}
