-----------------------------
-- blazin-g.nvim
-- @see https://github.com/krzmknt/blazin-g.nvim
-----------------------------

return {
	"krzmknt/blazin-g.nvim",
	build = "cargo install blazing",
	keys = {
		{ "<C-g>", function() require("blazin-g").open() end, desc = "Open blazing (g) in floating window" },
	},
	config = function()
		require("blazin-g").setup()
	end,
}
