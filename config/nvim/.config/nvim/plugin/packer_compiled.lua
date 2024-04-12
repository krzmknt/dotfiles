-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

_G._packer = _G._packer or {}
_G._packer.inside_compile = true

local time
local profile_info
local should_profile = false
if should_profile then
  local hrtime = vim.loop.hrtime
  profile_info = {}
  time = function(chunk, start)
    if start then
      profile_info[chunk] = hrtime()
    else
      profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
    end
  end
else
  time = function(chunk, start) end
end

local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end
  if threshold then
    table.insert(results, '(Only showing plugins that took longer than ' .. threshold .. ' ms ' .. 'to load)')
  end

  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/Users/krzmknt/.cache/nvim/packer_hererocks/2.1.1710088188/share/lua/5.1/?.lua;/Users/krzmknt/.cache/nvim/packer_hererocks/2.1.1710088188/share/lua/5.1/?/init.lua;/Users/krzmknt/.cache/nvim/packer_hererocks/2.1.1710088188/lib/luarocks/rocks-5.1/?.lua;/Users/krzmknt/.cache/nvim/packer_hererocks/2.1.1710088188/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/Users/krzmknt/.cache/nvim/packer_hererocks/2.1.1710088188/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["barbecue.nvim"] = {
    config = { "\27LJ\2\nW\0\0\3\0\4\0\f6\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\0016\0\0\0'\2\1\0B\0\2\0029\0\3\0)\2\2\0B\0\2\1K\0\1\0\rnavigate\nsetup\rbarbecue\frequire\0" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/Users/krzmknt/.local/share/nvim/site/pack/packer/opt/barbecue.nvim",
    url = "https://github.com/utilyre/barbecue.nvim"
  },
  ["black-nvim"] = {
    loaded = true,
    path = "/Users/krzmknt/.local/share/nvim/site/pack/packer/start/black-nvim",
    url = "https://github.com/averms/black-nvim"
  },
  ["bufferline.nvim"] = {
    loaded = true,
    path = "/Users/krzmknt/.local/share/nvim/site/pack/packer/start/bufferline.nvim",
    url = "https://github.com/akinsho/bufferline.nvim"
  },
  catppuccin = {
    loaded = true,
    path = "/Users/krzmknt/.local/share/nvim/site/pack/packer/start/catppuccin",
    url = "https://github.com/catppuccin/nvim"
  },
  ["coc.nvim"] = {
    loaded = true,
    path = "/Users/krzmknt/.local/share/nvim/site/pack/packer/start/coc.nvim",
    url = "https://github.com/neoclide/coc.nvim"
  },
  ["copilot.vim"] = {
    loaded = true,
    path = "/Users/krzmknt/.local/share/nvim/site/pack/packer/start/copilot.vim",
    url = "https://github.com/github/copilot.vim"
  },
  ["fine-cmdline.nvim"] = {
    loaded = true,
    path = "/Users/krzmknt/.local/share/nvim/site/pack/packer/start/fine-cmdline.nvim",
    url = "https://github.com/VonHeikemen/fine-cmdline.nvim"
  },
  ["gitsigns.nvim"] = {
    config = { "\27LJ\2\n�\6\0\0\5\0\26\0\0296\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\16\0005\3\4\0005\4\3\0=\4\5\0035\4\6\0=\4\a\0035\4\b\0=\4\t\0035\4\n\0=\4\v\0035\4\f\0=\4\r\0035\4\14\0=\4\15\3=\3\17\0025\3\18\0=\3\19\0025\3\20\0=\3\21\0025\3\22\0=\3\23\0025\3\24\0=\3\25\2B\0\2\1K\0\1\0\tyadm\1\0\1\venable\1\19preview_config\1\0\5\vborder\vsingle\bcol\3\1\brow\3\0\rrelative\vcursor\nstyle\fminimal\28current_line_blame_opts\1\0\5\22ignore_whitespace\1\ndelay\3\0\18virt_text_pos\beol\14virt_text\2\23virt_text_priority\3d\17watch_gitdir\1\0\1\17follow_files\2\nsigns\1\0\16\tyadm\0\20max_file_length\3��\2\20update_debounce\3d\18sign_priority\3\6\28current_line_blame_opts\0\15signcolumn\2\23current_line_blame\2\24attach_to_untracked\2\19preview_config\0\nsigns\0\17watch_gitdir\0\14word_diff\2\vlinehl\1\nnumhl\1!current_line_blame_formatter1<author>, <author_time:%Y-%m-%d> - <summary>\16auto_attach\2\14untracked\1\0\1\ttext\b┆\17changedelete\1\0\1\ttext\6~\14topdelete\1\0\1\ttext\b‾\vdelete\1\0\1\ttext\6_\vchange\1\0\1\ttext\b│\badd\1\0\6\badd\0\17changedelete\0\14topdelete\0\vdelete\0\vchange\0\14untracked\0\1\0\1\ttext\b│\nsetup\rgitsigns\frequire\0" },
    loaded = true,
    path = "/Users/krzmknt/.local/share/nvim/site/pack/packer/start/gitsigns.nvim",
    url = "https://github.com/lewis6991/gitsigns.nvim"
  },
  ["hlargs.nvim"] = {
    config = { "\27LJ\2\n4\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\vhlargs\frequire\0" },
    loaded = true,
    path = "/Users/krzmknt/.local/share/nvim/site/pack/packer/start/hlargs.nvim",
    url = "https://github.com/m-demare/hlargs.nvim"
  },
  ["indent-blankline.nvim"] = {
    config = { "\27LJ\2\n�\3\0\0\5\0\17\00026\0\0\0009\0\1\0009\0\2\0)\2\0\0'\3\3\0005\4\4\0B\0\4\0016\0\0\0009\0\1\0009\0\2\0)\2\0\0'\3\5\0005\4\6\0B\0\4\0016\0\0\0009\0\1\0009\0\2\0)\2\0\0'\3\a\0005\4\b\0B\0\4\0016\0\0\0009\0\1\0009\0\2\0)\2\0\0'\3\t\0005\4\n\0B\0\4\0016\0\0\0009\0\1\0009\0\2\0)\2\0\0'\3\v\0005\4\f\0B\0\4\0016\0\0\0009\0\1\0009\0\2\0)\2\0\0'\3\r\0005\4\14\0B\0\4\0016\0\0\0009\0\1\0009\0\2\0)\2\0\0'\3\15\0005\4\16\0B\0\4\1K\0\1\0\1\0\1\afg\f#56B6C2\16RainbowCyan\1\0\1\afg\f#C678DD\18RainbowViolet\1\0\1\afg\f#98C379\17RainbowGreen\1\0\1\afg\f#D19A66\18RainbowOrange\1\0\1\afg\f#61AFEF\16RainbowBlue\1\0\1\afg\f#E5C07B\18RainbowYellow\1\0\1\afg\f#E06C75\15RainbowRed\16nvim_set_hl\bapi\bvim�\1\1\0\5\0\t\0\0156\0\0\0'\2\1\0B\0\2\0029\1\2\0009\3\3\0009\3\4\0033\4\5\0B\1\3\0015\1\6\0006\2\0\0'\4\a\0B\2\2\0029\2\b\2B\2\1\1K\0\1\0\nsetup\bibl\1\b\0\0\15RainbowRed\18RainbowYellow\16RainbowBlue\18RainbowOrange\17RainbowGreen\18RainbowViolet\16RainbowCyan\0\20HIGHLIGHT_SETUP\ttype\rregister\14ibl.hooks\frequire\0" },
    loaded = true,
    path = "/Users/krzmknt/.local/share/nvim/site/pack/packer/start/indent-blankline.nvim",
    url = "https://github.com/lukas-reineke/indent-blankline.nvim"
  },
  ["isort.vim"] = {
    loaded = true,
    path = "/Users/krzmknt/.local/share/nvim/site/pack/packer/start/isort.vim",
    url = "https://github.com/brentyi/isort.vim"
  },
  ["lualine.nvim"] = {
    loaded = true,
    path = "/Users/krzmknt/.local/share/nvim/site/pack/packer/start/lualine.nvim",
    url = "https://github.com/nvim-lualine/lualine.nvim"
  },
  ["memolist.vim"] = {
    loaded = true,
    path = "/Users/krzmknt/.local/share/nvim/site/pack/packer/start/memolist.vim",
    url = "https://github.com/glidenote/memolist.vim"
  },
  nerdcommenter = {
    loaded = true,
    path = "/Users/krzmknt/.local/share/nvim/site/pack/packer/start/nerdcommenter",
    url = "https://github.com/scrooloose/nerdcommenter"
  },
  ["nui.nvim"] = {
    loaded = true,
    path = "/Users/krzmknt/.local/share/nvim/site/pack/packer/start/nui.nvim",
    url = "https://github.com/MunifTanjim/nui.nvim"
  },
  ["nvim-autopairs"] = {
    loaded = true,
    path = "/Users/krzmknt/.local/share/nvim/site/pack/packer/start/nvim-autopairs",
    url = "https://github.com/windwp/nvim-autopairs"
  },
  ["nvim-colorizer.lua"] = {
    config = { "\27LJ\2\n7\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\1\2\0B\1\1\1K\0\1\0\nsetup\14colorizer\frequire\0" },
    loaded = true,
    path = "/Users/krzmknt/.local/share/nvim/site/pack/packer/start/nvim-colorizer.lua",
    url = "https://github.com/norcalli/nvim-colorizer.lua"
  },
  ["nvim-dap"] = {
    loaded = true,
    path = "/Users/krzmknt/.local/share/nvim/site/pack/packer/start/nvim-dap",
    url = "https://github.com/mfussenegger/nvim-dap"
  },
  ["nvim-dap-python"] = {
    loaded = true,
    path = "/Users/krzmknt/.local/share/nvim/site/pack/packer/start/nvim-dap-python",
    url = "https://github.com/mfussenegger/nvim-dap-python"
  },
  ["nvim-dap-ui"] = {
    loaded = true,
    path = "/Users/krzmknt/.local/share/nvim/site/pack/packer/start/nvim-dap-ui",
    url = "https://github.com/rcarriga/nvim-dap-ui"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/Users/krzmknt/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-navic"] = {
    loaded = true,
    path = "/Users/krzmknt/.local/share/nvim/site/pack/packer/start/nvim-navic",
    url = "https://github.com/SmiteshP/nvim-navic"
  },
  ["nvim-scrollbar"] = {
    config = { "\27LJ\2\n7\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\14scrollbar\frequire\0" },
    loaded = true,
    path = "/Users/krzmknt/.local/share/nvim/site/pack/packer/start/nvim-scrollbar",
    url = "https://github.com/petertriho/nvim-scrollbar"
  },
  ["nvim-treesitter"] = {
    config = { "\27LJ\2\n�\2\0\0\6\0\15\0\0226\0\0\0'\2\1\0B\0\2\2+\1\2\0=\1\2\0006\0\0\0'\2\3\0B\0\2\0029\1\4\0005\3\6\0005\4\5\0=\4\a\0035\4\b\0004\5\0\0=\5\t\4=\4\n\0035\4\v\0=\4\f\0035\4\r\0=\4\14\3B\1\2\1K\0\1\0\fautotag\1\0\1\venable\2\vindent\1\0\1\venable\2\14highlight\fdisable\1\0\2\venable\2\fdisable\0\21ensure_installed\1\0\4\fautotag\0\21ensure_installed\0\14highlight\0\vindent\0\1\r\0\0\bcss\tfish\thtml\tjava\15javascript\tjson\blua\vpython\btsx\15typescript\bvim\tyaml\nsetup\28nvim-treesitter.configs\15prefer_git\28nvim-treesitter.install\frequire\0" },
    loaded = true,
    path = "/Users/krzmknt/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-web-devicons"] = {
    after = { "barbecue.nvim" },
    config = { "\27LJ\2\n�\3\0\0\5\0\16\0\0196\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\6\0005\3\4\0005\4\3\0=\4\5\3=\3\a\0025\3\t\0005\4\b\0=\4\n\3=\3\v\0025\3\r\0005\4\f\0=\4\14\3=\3\15\2B\0\2\1K\0\1\0\26override_by_extension\blog\1\0\1\blog\0\1\0\3\ncolor\f#81e043\tname\bLog\ticon\b\25override_by_filename\15.gitignore\1\0\1\15.gitignore\0\1\0\3\ncolor\f#f1502f\tname\14Gitignore\ticon\b\roverride\1\0\6\roverride\0\25override_by_filename\0\26override_by_extension\0\fdefault\2\vstrict\2\16color_icons\2\bzsh\1\0\1\bzsh\0\1\0\4\ncolor\f#428850\tname\bZsh\ticon\b\16cterm_color\a65\nsetup\22nvim-web-devicons\frequire\0" },
    loaded = true,
    only_config = true,
    path = "/Users/krzmknt/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://github.com/nvim-tree/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/Users/krzmknt/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/Users/krzmknt/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/Users/krzmknt/.local/share/nvim/site/pack/packer/start/popup.nvim",
    url = "https://github.com/nvim-lua/popup.nvim"
  },
  ["prettier.nvim"] = {
    loaded = true,
    path = "/Users/krzmknt/.local/share/nvim/site/pack/packer/start/prettier.nvim",
    url = "https://github.com/MunifTanjim/prettier.nvim"
  },
  ["telescope-file-browser.nvim"] = {
    config = { "\27LJ\2\nI\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0B\0\2\1K\0\1\0\tmemo\19load_extension\14telescope\frequire\0" },
    loaded = true,
    path = "/Users/krzmknt/.local/share/nvim/site/pack/packer/start/telescope-file-browser.nvim",
    url = "https://github.com/nvim-telescope/telescope-file-browser.nvim"
  },
  ["telescope-memo.nvim"] = {
    loaded = true,
    path = "/Users/krzmknt/.local/share/nvim/site/pack/packer/start/telescope-memo.nvim",
    url = "https://github.com/delphinus/telescope-memo.nvim"
  },
  ["telescope.nvim"] = {
    loaded = true,
    path = "/Users/krzmknt/.local/share/nvim/site/pack/packer/start/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["transparent.nvim"] = {
    config = { "\27LJ\2\n�\2\0\0\4\0\b\0\r6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0024\3\0\0=\3\6\0024\3\0\0=\3\a\2B\0\2\1K\0\1\0\19exclude_groups\17extra_groups\vgroups\1\0\3\vgroups\0\19exclude_groups\0\17extra_groups\0\1\23\0\0\vNormal\rNormalNC\fComment\rConstant\fSpecial\15Identifier\14Statement\fPreProc\tType\15Underlined\tTodo\vString\rFunction\16Conditional\vRepeat\rOperator\14Structure\vLineNr\fNonText\15SignColumn\17CursorLineNr\16EndOfBuffer\nsetup\16transparent\frequire\0" },
    loaded = true,
    path = "/Users/krzmknt/.local/share/nvim/site/pack/packer/start/transparent.nvim",
    url = "https://github.com/xiyaowong/transparent.nvim"
  },
  ["vim-floaterm"] = {
    loaded = true,
    path = "/Users/krzmknt/.local/share/nvim/site/pack/packer/start/vim-floaterm",
    url = "https://github.com/voldikss/vim-floaterm"
  },
  ["vim-fugitive"] = {
    config = { "\27LJ\2\n�\1\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0�\1        nnoremap <leader>gs :Git status<CR>\n        nnoremap <leader>gd :Gdiff<CR>\n        nnoremap <leader>gb :Git blame<CR>\n        nnoremap <leader>gl :Git log --graph<CR>\n      \bcmd\bvim\0" },
    loaded = true,
    path = "/Users/krzmknt/.local/share/nvim/site/pack/packer/start/vim-fugitive",
    url = "https://github.com/tpope/vim-fugitive"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: nvim-colorizer.lua
time([[Config for nvim-colorizer.lua]], true)
try_loadstring("\27LJ\2\n7\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\1\2\0B\1\1\1K\0\1\0\nsetup\14colorizer\frequire\0", "config", "nvim-colorizer.lua")
time([[Config for nvim-colorizer.lua]], false)
-- Config for: nvim-scrollbar
time([[Config for nvim-scrollbar]], true)
try_loadstring("\27LJ\2\n7\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\14scrollbar\frequire\0", "config", "nvim-scrollbar")
time([[Config for nvim-scrollbar]], false)
-- Config for: nvim-web-devicons
time([[Config for nvim-web-devicons]], true)
try_loadstring("\27LJ\2\n�\3\0\0\5\0\16\0\0196\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\6\0005\3\4\0005\4\3\0=\4\5\3=\3\a\0025\3\t\0005\4\b\0=\4\n\3=\3\v\0025\3\r\0005\4\f\0=\4\14\3=\3\15\2B\0\2\1K\0\1\0\26override_by_extension\blog\1\0\1\blog\0\1\0\3\ncolor\f#81e043\tname\bLog\ticon\b\25override_by_filename\15.gitignore\1\0\1\15.gitignore\0\1\0\3\ncolor\f#f1502f\tname\14Gitignore\ticon\b\roverride\1\0\6\roverride\0\25override_by_filename\0\26override_by_extension\0\fdefault\2\vstrict\2\16color_icons\2\bzsh\1\0\1\bzsh\0\1\0\4\ncolor\f#428850\tname\bZsh\ticon\b\16cterm_color\a65\nsetup\22nvim-web-devicons\frequire\0", "config", "nvim-web-devicons")
time([[Config for nvim-web-devicons]], false)
-- Config for: nvim-treesitter
time([[Config for nvim-treesitter]], true)
try_loadstring("\27LJ\2\n�\2\0\0\6\0\15\0\0226\0\0\0'\2\1\0B\0\2\2+\1\2\0=\1\2\0006\0\0\0'\2\3\0B\0\2\0029\1\4\0005\3\6\0005\4\5\0=\4\a\0035\4\b\0004\5\0\0=\5\t\4=\4\n\0035\4\v\0=\4\f\0035\4\r\0=\4\14\3B\1\2\1K\0\1\0\fautotag\1\0\1\venable\2\vindent\1\0\1\venable\2\14highlight\fdisable\1\0\2\venable\2\fdisable\0\21ensure_installed\1\0\4\fautotag\0\21ensure_installed\0\14highlight\0\vindent\0\1\r\0\0\bcss\tfish\thtml\tjava\15javascript\tjson\blua\vpython\btsx\15typescript\bvim\tyaml\nsetup\28nvim-treesitter.configs\15prefer_git\28nvim-treesitter.install\frequire\0", "config", "nvim-treesitter")
time([[Config for nvim-treesitter]], false)
-- Config for: hlargs.nvim
time([[Config for hlargs.nvim]], true)
try_loadstring("\27LJ\2\n4\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\vhlargs\frequire\0", "config", "hlargs.nvim")
time([[Config for hlargs.nvim]], false)
-- Config for: transparent.nvim
time([[Config for transparent.nvim]], true)
try_loadstring("\27LJ\2\n�\2\0\0\4\0\b\0\r6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0024\3\0\0=\3\6\0024\3\0\0=\3\a\2B\0\2\1K\0\1\0\19exclude_groups\17extra_groups\vgroups\1\0\3\vgroups\0\19exclude_groups\0\17extra_groups\0\1\23\0\0\vNormal\rNormalNC\fComment\rConstant\fSpecial\15Identifier\14Statement\fPreProc\tType\15Underlined\tTodo\vString\rFunction\16Conditional\vRepeat\rOperator\14Structure\vLineNr\fNonText\15SignColumn\17CursorLineNr\16EndOfBuffer\nsetup\16transparent\frequire\0", "config", "transparent.nvim")
time([[Config for transparent.nvim]], false)
-- Config for: telescope-file-browser.nvim
time([[Config for telescope-file-browser.nvim]], true)
try_loadstring("\27LJ\2\nI\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0B\0\2\1K\0\1\0\tmemo\19load_extension\14telescope\frequire\0", "config", "telescope-file-browser.nvim")
time([[Config for telescope-file-browser.nvim]], false)
-- Config for: vim-fugitive
time([[Config for vim-fugitive]], true)
try_loadstring("\27LJ\2\n�\1\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0�\1        nnoremap <leader>gs :Git status<CR>\n        nnoremap <leader>gd :Gdiff<CR>\n        nnoremap <leader>gb :Git blame<CR>\n        nnoremap <leader>gl :Git log --graph<CR>\n      \bcmd\bvim\0", "config", "vim-fugitive")
time([[Config for vim-fugitive]], false)
-- Config for: indent-blankline.nvim
time([[Config for indent-blankline.nvim]], true)
try_loadstring("\27LJ\2\n�\3\0\0\5\0\17\00026\0\0\0009\0\1\0009\0\2\0)\2\0\0'\3\3\0005\4\4\0B\0\4\0016\0\0\0009\0\1\0009\0\2\0)\2\0\0'\3\5\0005\4\6\0B\0\4\0016\0\0\0009\0\1\0009\0\2\0)\2\0\0'\3\a\0005\4\b\0B\0\4\0016\0\0\0009\0\1\0009\0\2\0)\2\0\0'\3\t\0005\4\n\0B\0\4\0016\0\0\0009\0\1\0009\0\2\0)\2\0\0'\3\v\0005\4\f\0B\0\4\0016\0\0\0009\0\1\0009\0\2\0)\2\0\0'\3\r\0005\4\14\0B\0\4\0016\0\0\0009\0\1\0009\0\2\0)\2\0\0'\3\15\0005\4\16\0B\0\4\1K\0\1\0\1\0\1\afg\f#56B6C2\16RainbowCyan\1\0\1\afg\f#C678DD\18RainbowViolet\1\0\1\afg\f#98C379\17RainbowGreen\1\0\1\afg\f#D19A66\18RainbowOrange\1\0\1\afg\f#61AFEF\16RainbowBlue\1\0\1\afg\f#E5C07B\18RainbowYellow\1\0\1\afg\f#E06C75\15RainbowRed\16nvim_set_hl\bapi\bvim�\1\1\0\5\0\t\0\0156\0\0\0'\2\1\0B\0\2\0029\1\2\0009\3\3\0009\3\4\0033\4\5\0B\1\3\0015\1\6\0006\2\0\0'\4\a\0B\2\2\0029\2\b\2B\2\1\1K\0\1\0\nsetup\bibl\1\b\0\0\15RainbowRed\18RainbowYellow\16RainbowBlue\18RainbowOrange\17RainbowGreen\18RainbowViolet\16RainbowCyan\0\20HIGHLIGHT_SETUP\ttype\rregister\14ibl.hooks\frequire\0", "config", "indent-blankline.nvim")
time([[Config for indent-blankline.nvim]], false)
-- Config for: gitsigns.nvim
time([[Config for gitsigns.nvim]], true)
try_loadstring("\27LJ\2\n�\6\0\0\5\0\26\0\0296\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\16\0005\3\4\0005\4\3\0=\4\5\0035\4\6\0=\4\a\0035\4\b\0=\4\t\0035\4\n\0=\4\v\0035\4\f\0=\4\r\0035\4\14\0=\4\15\3=\3\17\0025\3\18\0=\3\19\0025\3\20\0=\3\21\0025\3\22\0=\3\23\0025\3\24\0=\3\25\2B\0\2\1K\0\1\0\tyadm\1\0\1\venable\1\19preview_config\1\0\5\vborder\vsingle\bcol\3\1\brow\3\0\rrelative\vcursor\nstyle\fminimal\28current_line_blame_opts\1\0\5\22ignore_whitespace\1\ndelay\3\0\18virt_text_pos\beol\14virt_text\2\23virt_text_priority\3d\17watch_gitdir\1\0\1\17follow_files\2\nsigns\1\0\16\tyadm\0\20max_file_length\3��\2\20update_debounce\3d\18sign_priority\3\6\28current_line_blame_opts\0\15signcolumn\2\23current_line_blame\2\24attach_to_untracked\2\19preview_config\0\nsigns\0\17watch_gitdir\0\14word_diff\2\vlinehl\1\nnumhl\1!current_line_blame_formatter1<author>, <author_time:%Y-%m-%d> - <summary>\16auto_attach\2\14untracked\1\0\1\ttext\b┆\17changedelete\1\0\1\ttext\6~\14topdelete\1\0\1\ttext\b‾\vdelete\1\0\1\ttext\6_\vchange\1\0\1\ttext\b│\badd\1\0\6\badd\0\17changedelete\0\14topdelete\0\vdelete\0\vchange\0\14untracked\0\1\0\1\ttext\b│\nsetup\rgitsigns\frequire\0", "config", "gitsigns.nvim")
time([[Config for gitsigns.nvim]], false)
-- Load plugins in order defined by `after`
time([[Sequenced loading]], true)
vim.cmd [[ packadd barbecue.nvim ]]

-- Config for: barbecue.nvim
try_loadstring("\27LJ\2\nW\0\0\3\0\4\0\f6\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\0016\0\0\0'\2\1\0B\0\2\0029\0\3\0)\2\2\0B\0\2\1K\0\1\0\rnavigate\nsetup\rbarbecue\frequire\0", "config", "barbecue.nvim")

time([[Sequenced loading]], false)

_G._packer.inside_compile = false
if _G._packer.needs_bufread == true then
  vim.cmd("doautocmd BufRead")
end
_G._packer.needs_bufread = false

if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
