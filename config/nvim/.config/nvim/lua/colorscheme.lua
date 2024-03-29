vim.cmd [[
  " colorscheme terafox
  highlight SignColumn ctermbg=none guibg=none
  highlight LineNr ctermbg=none guibg=none
  highlight Normal ctermbg=none guibg=none
  highlight NonText ctermbg=none guibg=none
  highlight NvimTreeNormal ctermbg=none guibg=none
]]


require('monokai').setup {
  -- palette = require('monokai').ristretto,
  italics = false
}

vim.cmd.colorscheme "catppuccin"

