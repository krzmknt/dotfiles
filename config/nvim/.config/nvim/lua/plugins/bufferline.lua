return {
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("bufferline").setup({
				options = {
					mode = "tabs",
					style_preset = require("bufferline").style_preset.minimal,
					themable = true,
					numbers = "none",

					-- Close icon
					close_command = "bdelete! %d",
					right_mouse_command = "bdelete! %d",
					left_mouse_command = "buffer %d",
					middle_mouse_command = nil,

					-- Icons
					indicator = {
						icon = "▎",
						style = "icon",
					},
					buffer_close_icon = "",
					modified_icon = "●",
					close_icon = "",
					left_trunc_marker = "",
					right_trunc_marker = "",

					-- Name formatting
					name_formatter = function(buf)
						-- Hide buffer number, show only filename
						return buf.name
					end,
					max_name_length = 18,
					max_prefix_length = 15,
					truncate_names = true,
					tab_size = 18,

					-- Diagnostics (disabled - don't change display based on diagnostics)
					diagnostics = false,

					-- Color and style
					color_icons = true,
					show_buffer_icons = true,
					show_buffer_close_icons = false,
					show_close_icon = false,
					show_tab_indicators = false,
					show_duplicate_prefix = true,
					persist_buffer_sort = true,

					-- Separator style: "slant" | "slope" | "thick" | "thin" | "padded_slant"
					separator_style = "thin",
					enforce_regular_tabs = false,
					always_show_bufferline = true,

					-- Hover effects
					hover = {
						enabled = true,
						delay = 200,
						reveal = { "close" },
					},

					-- Sorting
					sort_by = "id",

					-- Offset for nvim-tree
					offsets = {
						{
							filetype = "NvimTree",
							text = "",
							separator = true,
							highlight = "NvimTreeNormal",
						},
					},
				},

				highlights = {
					fill = {
						bg = "NONE",
					},
					background = {
						fg = "#5c6370",
						bg = "NONE",
					},
					tab = {
						fg = "#5c6370",
						bg = "NONE",
					},
					tab_selected = {
						fg = "#c678dd",
						bg = "#1a1a2e",
						bold = true,
					},
					tab_separator = {
						fg = "#3e4452",
						bg = "NONE",
					},
					tab_separator_selected = {
						fg = "#3e4452",
						bg = "#1a1a2e",
					},
					tab_close = {
						bg = "NONE",
					},
					close_button = {
						fg = "#5c6370",
						bg = "NONE",
					},
					close_button_visible = {
						fg = "#5c6370",
						bg = "NONE",
					},
					close_button_selected = {
						fg = "#c678dd",
						bg = "#1a1a2e",
					},
					buffer = {
						fg = "#5c6370",
						bg = "NONE",
					},
					buffer_visible = {
						fg = "#abb2bf",
						bg = "NONE",
					},
					buffer_selected = {
						fg = "#c678dd",
						bg = "#1a1a2e",
						bold = true,
						italic = false,
					},
					numbers = {
						fg = "#5c6370",
						bg = "NONE",
					},
					numbers_visible = {
						fg = "#5c6370",
						bg = "NONE",
					},
					numbers_selected = {
						fg = "#c678dd",
						bg = "#1a1a2e",
						bold = true,
					},
					modified = {
						fg = "#e5c07b",
						bg = "NONE",
					},
					modified_visible = {
						fg = "#e5c07b",
						bg = "NONE",
					},
					modified_selected = {
						fg = "#e5c07b",
						bg = "#1a1a2e",
					},
					duplicate_selected = {
						fg = "#c678dd",
						bg = "#1a1a2e",
						italic = false,
					},
					duplicate_visible = {
						fg = "#5c6370",
						bg = "NONE",
						italic = false,
					},
					duplicate = {
						fg = "#5c6370",
						bg = "NONE",
						italic = false,
					},
					separator = {
						fg = "#3e4452",
						bg = "NONE",
					},
					separator_selected = {
						fg = "#3e4452",
						bg = "#1a1a2e",
					},
					separator_visible = {
						fg = "#3e4452",
						bg = "NONE",
					},
					indicator_selected = {
						fg = "#c678dd",
						bg = "#1a1a2e",
					},
					indicator_visible = {
						fg = "#5c6370",
						bg = "NONE",
					},
					pick_selected = {
						fg = "#e06c75",
						bg = "#1a1a2e",
						bold = true,
						italic = false,
					},
					pick_visible = {
						fg = "#e06c75",
						bg = "NONE",
						bold = true,
						italic = false,
					},
					pick = {
						fg = "#e06c75",
						bg = "NONE",
						bold = true,
						italic = false,
					},
				},
			})
		end,
	},
}
