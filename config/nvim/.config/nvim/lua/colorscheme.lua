vim.cmd [[
  colorscheme terafox
  "highlight SignColumn ctermbg=none guibg=none
  "highlight LineNr ctermbg=none guibg=none
  "highlight Normal ctermbg=none guibg=none
  "highlight NonText ctermbg=none guibg=none
  "highlight NvimTreeNormal ctermbg=none guibg=none
  command! -nargs=0 Prettier :call CocAction('runCommand', 'prettier.formatFile')
]]
