-----------------------------
-- NERDCommenter
-- @see https://github.com/preservim/nerdcommenter#default-mappings
-----------------------------

return {
	"scrooloose/nerdcommenter",
	config = function()
		vim.g.NERDSpaceDelims = 1
		vim.g.NERDDefaultAlign = "left"
	end,
}
