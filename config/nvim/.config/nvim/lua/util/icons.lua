local icons = {}

icons.mode = {
	["NORMAL"] = "",
	["INSERT"] = "",
	["VISUAL"] = "󰍉",
	["V-LINE"] = "󰍉",
	["V-BLOCK"] = "󰍉",
	["COMMAND"] = "",
}

icons.diagnostic = {
	error = "",
	-- error = " ",
	warn = " ",
	info = " ",
	hint = " ",
}

icons.platform = {
	windows = "",
	unix = "",
	mac = "",
}

icons.separator = {
	rounded = {
		left = "",
		right = "",
	},
}

icons.filetype = {
	readonly = "󰌾 ",
}

icons.git = {
	logo = "󰊢",
	branch = "",
	added = "",
	modified = "",
	removed = "",
	untracked = "󰜛",
}

return icons
