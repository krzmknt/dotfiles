-------------------------------------------------
-- nvim-treesitter/nvim-treesitter
-- https://github.com/nvim-treesitter/nvim-treesitter
-------------------------------------------------
local status, treesitter = pcall(require, 'nvim-treesitter.configs')
if (not status) then return end

treesitter.setup {
  ensure_installed = {
    "css",
    "fish",
    "html",
    "json",
    "lua",
    "python",
    "tsx",
    "vim",
    "yaml"
  },

  highlight = {
    enable = true,
    disable = {},
  },

  indent = {
    enable = true,
  },

  autotag = {
    enable = true,
  }
}
