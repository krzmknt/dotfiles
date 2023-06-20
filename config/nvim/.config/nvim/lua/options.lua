local options = {
  background = 'dark',
  backup = false,
  backupskip = { '/tmp/*', '/private/tmp/*' },
  clipboard = 'unnamedplus',
  cmdheight = 1,
  completeopt = { 'menuone', 'noselect' },
  conceallevel = 0,
  cursorline = true,
  encoding = 'utf-8',
  expandtab = true,
  fileencoding = 'utf-8',
  guifont = 'monospace:h17',
  hlsearch = true,
  ignorecase = true,
  mouse = 'a',
  number = true,
  numberwidth = 4,
  pumblend = 5,
  pumheight = 10,
  relativenumber = false,
  scrolloff = 8,
  shell = 'fish',
  shiftwidth = 2,
  showmode = false,
  showtabline = 2,
  sidescrolloff = 8,
  signcolumn = 'yes',
  smartcase = true,
  smartindent = true,
  splitbelow = false,
  splitright = false,
  swapfile = false,
  tabstop = 2,
  termguicolors = true,
  timeoutlen = 300,
  title = true,
  undofile = true,
  updatetime = 300,
  wildoptions = 'pum',
  winblend = 0,
  wrap = false,
  writebackup = false,
}

vim.opt.shortmess:append('c')

for key, value in pairs(options) do
  vim.opt[key] = value
end

vim.cmd('set whichwrap+=<,>,[,],h,l')
vim.cmd([[set iskeyword+=-]])
vim.cmd([[set formatoptions-=cro]]) -- TODO: this doesn't seem to work


