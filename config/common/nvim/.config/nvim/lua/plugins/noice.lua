return {
	"folke/noice.nvim",
	event = "VeryLazy",
	dependencies = {
		"MunifTanjim/nui.nvim",
		{
			"rcarriga/nvim-notify",
			opts = {
				top_down = false, -- Bottom up (notifications appear from bottom)
				stages = "fade_in_slide_out",
				timeout = 3000,
				render = "compact",
				max_width = 50,
			},
		},
	},
	config = function()
		require("noice").setup({
			-- Command line popup
			cmdline = {
				enabled = true,
				view = "cmdline_popup",
				format = {
					cmdline = { pattern = "^:", icon = "", lang = "vim" },
					search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
					search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
					filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
					lua = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = "", lang = "lua" },
					help = { pattern = "^:%s*he?l?p?%s+", icon = "󰋖" },
				},
			},

			-- Messages
			messages = {
				enabled = true,
				view = "notify",
				view_error = "notify",
				view_warn = "notify",
				view_history = "messages",
				view_search = "virtualtext",
			},

			-- Popup menu
			popupmenu = {
				enabled = true,
				backend = "nui",
			},

			-- LSP
			lsp = {
				progress = {
					enabled = true,
					view = "mini",
				},
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
				hover = {
					enabled = true,
				},
				signature = {
					enabled = true,
				},
			},

			-- Presets
			presets = {
				bottom_search = false, -- Disable to use centered search
				command_palette = false, -- Disable to use custom centered cmdline
				long_message_to_split = true,
				inc_rename = false,
				lsp_doc_border = true,
			},

			-- Views
			views = {
				cmdline_popup = {
					position = {
						row = "50%",
						col = "50%",
					},
					size = {
						width = 60,
						height = "auto",
					},
				},
				notify = {
					replace = true,
				},
				mini = {
					position = {
						row = -2,
						col = "100%",
					},
				},
			},

			-- Routes
			routes = {
				-- Hide "written" messages
				{
					filter = {
						event = "msg_show",
						kind = "",
						find = "written",
					},
					opts = { skip = true },
				},
				-- Hide search count messages
				{
					filter = {
						event = "msg_show",
						kind = "search_count",
					},
					opts = { skip = true },
				},
			},
		})

		-- Configure nvim-notify position (bottom right)
		local notify = require("notify")
		notify.setup({
			top_down = false,
			stages = "fade_in_slide_out",
			timeout = 3000,
			render = "compact",
			max_width = 50,
			background_colour = "#000000",
		})
	end,
}
