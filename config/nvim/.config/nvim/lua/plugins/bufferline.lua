return {
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("bufferline").setup({
				options = {
					mode = "tabs", -- Show tabs instead of buffers
					style_preset = require("bufferline").style_preset.default,
					themable = true,
					numbers = "none", -- Disable tab numbers

					-- Close icon
					close_command = "bdelete! %d",
					right_mouse_command = "bdelete! %d",
					left_mouse_command = "buffer %d",
					middle_mouse_command = nil,

					-- Icons
					indicator = {
						icon = "▎", -- this should be omitted if indicator style is not 'icon'
						style = "icon", -- 'icon' | 'underline' | 'none'
					},
					buffer_close_icon = "", -- Disable close icon
					modified_icon = "●",
					close_icon = "", -- Disable close icon
					left_trunc_marker = "",
					right_trunc_marker = "",

					-- Name formatting
					max_name_length = 18,
					max_prefix_length = 15,
					truncate_names = true,
					tab_size = 20,

					-- Diagnostics (LSP error/warning indicators)
					diagnostics = "nvim_lsp",
					diagnostics_update_in_insert = false,
					diagnostics_indicator = function(count, level, diagnostics_dict, context)
						local icon = level:match("error") and " " or " "
						return " " .. icon .. count
					end,

					-- Color and style
					color_icons = true,
					show_buffer_icons = true,
					show_buffer_close_icons = false, -- Hide close icons on tabs
					show_close_icon = false, -- Hide close icon in tabline
					show_tab_indicators = true,
					show_duplicate_prefix = true,
					persist_buffer_sort = true,

					-- Separator style: "slant" | "slope" | "thick" | "thin" | "padded_slant"
					separator_style = "thick",
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
							text = "File Explorer",
							text_align = "center",
							separator = true,
						},
					},
				},

				highlights = {
					fill = {
						bg = "#000000", -- Pure black background for tab bar
					},
					background = {
						bg = "#1a1a1a",
					},
					tab = {
						bg = "#1a1a1a",
					},
					tab_selected = {
						bg = "#000000",
						fg = "#c678dd", -- Purple for selected tab
						bold = true,
					},
					tab_separator = {
						fg = "#000000",
						bg = "#1a1a1a",
					},
					tab_separator_selected = {
						fg = "#000000",
						bg = "#000000",
					},
					tab_close = {
						bg = "#1a1a1a",
					},
					close_button = {
						bg = "#1a1a1a",
					},
					close_button_visible = {
						bg = "#1a1a1a",
					},
					close_button_selected = {
						bg = "#000000",
						fg = "#c678dd",
					},
					buffer_selected = {
						fg = "#c678dd",
						bold = true,
						italic = false,
					},
					modified = {
						bg = "#1a1a1a",
					},
					modified_selected = {
						fg = "#e5c07b",
						bg = "#000000",
					},
					duplicate_selected = {
						fg = "#c678dd",
						italic = false,
						bg = "#000000",
					},
					duplicate_visible = {
						italic = false,
						bg = "#1a1a1a",
					},
					duplicate = {
						italic = false,
						bg = "#1a1a1a",
					},
					separator = {
						fg = "#000000",
						bg = "#1a1a1a",
					},
					separator_selected = {
						fg = "#000000",
						bg = "#000000",
					},
					separator_visible = {
						fg = "#000000",
						bg = "#1a1a1a",
					},
					indicator_selected = {
						fg = "#c678dd",
						bg = "#000000",
					},
					pick_selected = {
						fg = "#e06c75",
						bg = "#000000",
						bold = true,
						italic = false,
					},
					pick_visible = {
						fg = "#e06c75",
						bg = "#1a1a1a",
						bold = true,
						italic = false,
					},
					pick = {
						fg = "#e06c75",
						bg = "#1a1a1a",
						bold = true,
						italic = false,
					},
				},
			})
		end,
	},
}
