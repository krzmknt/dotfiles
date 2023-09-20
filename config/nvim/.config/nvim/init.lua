require('base')
require('autocmds')
require('options')
require('keymaps')
require('colorscheme')
require('plugins')

package.path = package.path .. ";/Users/krzmknt/Workspace/procon/.config/nvim/procon-tools/lua/?.lua"
require('procon-tools')
