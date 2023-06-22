-------------------------------------------------
-- nvim-treesitter/nvim-treesitter
-- https://github.com/nvim-treesitter/nvim-treesitter
-------------------------------------------------

-- this line needed do to coorporate netowrk under a proxy
require("nvim-treesitter.install").prefer_git = true

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
