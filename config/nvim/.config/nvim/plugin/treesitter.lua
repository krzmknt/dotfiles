-- Needed in coorporate netowrk under a proxy
require("nvim-treesitter.install").prefer_git = true

local treesitter = require('nvim-treesitter.configs')
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
