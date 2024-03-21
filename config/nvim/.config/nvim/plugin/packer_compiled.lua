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
  ["git.nvim"] = {
    config = { "\27LJ\2\n∆\2\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\2B\0\2\1K\0\1\0\fkeymaps\1\0\n\tdiff\15<Leader>ad\24create_pull_request\15<Leader>an\22open_pull_request\15<Leader>ap\vbrowse\15<Leader>af\17blame_commit\t<CR>\15quit_blame\6q\16revert_file\15<Leader>gR\nblame\15<Leader>ao\vrevert\15<Leader>gr\15diff_close\15<Leader>ac\1\0\3\21default_mappings\2\18target_branch\tmain\fkeymaps\0\nsetup\bgit\frequire\0" },
    loaded = true,
    path = "/Users/krzmknt/.local/share/nvim/site/pack/packer/start/git.nvim",
    url = "https://github.com/dinhhuy258/git.nvim"
  },
  ["gitsigns.nvim"] = {
    config = { "\27LJ\2\n6\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\rgitsigns\frequire\0" },
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
    config = { "\27LJ\2\nü\3\0\0\5\0\17\00026\0\0\0009\0\1\0009\0\2\0)\2\0\0'\3\3\0005\4\4\0B\0\4\0016\0\0\0009\0\1\0009\0\2\0)\2\0\0'\3\5\0005\4\6\0B\0\4\0016\0\0\0009\0\1\0009\0\2\0)\2\0\0'\3\a\0005\4\b\0B\0\4\0016\0\0\0009\0\1\0009\0\2\0)\2\0\0'\3\t\0005\4\n\0B\0\4\0016\0\0\0009\0\1\0009\0\2\0)\2\0\0'\3\v\0005\4\f\0B\0\4\0016\0\0\0009\0\1\0009\0\2\0)\2\0\0'\3\r\0005\4\14\0B\0\4\0016\0\0\0009\0\1\0009\0\2\0)\2\0\0'\3\15\0005\4\16\0B\0\4\1K\0\1\0\1\0\1\afg\f#56B6C2\16RainbowCyan\1\0\1\afg\f#C678DD\18RainbowViolet\1\0\1\afg\f#98C379\17RainbowGreen\1\0\1\afg\f#D19A66\18RainbowOrange\1\0\1\afg\f#61AFEF\16RainbowBlue\1\0\1\afg\f#E5C07B\18RainbowYellow\1\0\1\afg\f#E06C75\15RainbowRed\16nvim_set_hl\bapi\bvim‹\1\1\0\5\0\t\0\0156\0\0\0'\2\1\0B\0\2\0029\1\2\0009\3\3\0009\3\4\0033\4\5\0B\1\3\0015\1\6\0006\2\0\0'\4\a\0B\2\2\0029\2\b\2B\2\1\1K\0\1\0\nsetup\bibl\1\b\0\0\15RainbowRed\18RainbowYellow\16RainbowBlue\18RainbowOrange\17RainbowGreen\18RainbowViolet\16RainbowCyan\0\20HIGHLIGHT_SETUP\ttype\rregister\14ibl.hooks\frequire\0" },
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
    config = { "\27LJ\2\nˇ\2\0\0\6\0\15\0\0226\0\0\0'\2\1\0B\0\2\2+\1\2\0=\1\2\0006\0\0\0'\2\3\0B\0\2\0029\1\4\0005\3\6\0005\4\5\0=\4\a\0035\4\b\0004\5\0\0=\5\t\4=\4\n\0035\4\v\0=\4\f\0035\4\r\0=\4\14\3B\1\2\1K\0\1\0\fautotag\1\0\1\venable\2\vindent\1\0\1\venable\2\14highlight\fdisable\1\0\2\venable\2\fdisable\0\21ensure_installed\1\0\4\vindent\0\fautotag\0\21ensure_installed\0\14highlight\0\1\r\0\0\bcss\tfish\thtml\tjava\15javascript\tjson\blua\vpython\btsx\15typescript\bvim\tyaml\nsetup\28nvim-treesitter.configs\15prefer_git\28nvim-treesitter.install\frequire\0" },
    loaded = true,
    path = "/Users/krzmknt/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-web-devicons"] = {
    after = { "barbecue.nvim" },
    config = { "\27LJ\2\nØ\3\0\0\5\0\16\0\0196\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\6\0005\3\4\0005\4\3\0=\4\5\3=\3\a\0025\3\t\0005\4\b\0=\4\n\3=\3\v\0025\3\r\0005\4\f\0=\4\14\3=\3\15\2B\0\2\1K\0\1\0\26override_by_extension\blog\1\0\1\blog\0\1\0\3\ncolor\f#81e043\tname\bLog\ticon\bÔêé\25override_by_filename\15.gitignore\1\0\1\15.gitignore\0\1\0\3\ncolor\f#f1502f\tname\14Gitignore\ticon\bÓúÇ\roverride\1\0\6\26override_by_extension\0\25override_by_filename\0\vstrict\2\16color_icons\2\roverride\0\fdefault\2\bzsh\1\0\1\bzsh\0\1\0\4\16cterm_color\a65\ncolor\f#428850\tname\bZsh\ticon\bÓûï\nsetup\22nvim-web-devicons\frequire\0" },
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
    loaded = true,
    path = "/Users/krzmknt/.local/share/nvim/site/pack/packer/start/telescope-file-browser.nvim",
    url = "https://github.com/nvim-telescope/telescope-file-browser.nvim"
  },
  ["telescope.nvim"] = {
    loaded = true,
    path = "/Users/krzmknt/.local/share/nvim/site/pack/packer/start/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["transparent.nvim"] = {
    config = { "\27LJ\2\nÈ\2\0\0\4\0\b\0\r6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0024\3\0\0=\3\6\0024\3\0\0=\3\a\2B\0\2\1K\0\1\0\19exclude_groups\17extra_groups\vgroups\1\0\3\17extra_groups\0\vgroups\0\19exclude_groups\0\1\23\0\0\vNormal\rNormalNC\fComment\rConstant\fSpecial\15Identifier\14Statement\fPreProc\tType\15Underlined\tTodo\vString\rFunction\16Conditional\vRepeat\rOperator\14Structure\vLineNr\fNonText\15SignColumn\17CursorLineNr\16EndOfBuffer\nsetup\16transparent\frequire\0" },
    loaded = true,
    path = "/Users/krzmknt/.local/share/nvim/site/pack/packer/start/transparent.nvim",
    url = "https://github.com/xiyaowong/transparent.nvim"
  },
  ["vim-floaterm"] = {
    loaded = true,
    path = "/Users/krzmknt/.local/share/nvim/site/pack/packer/start/vim-floaterm",
    url = "https://github.com/voldikss/vim-floaterm"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: indent-blankline.nvim
time([[Config for indent-blankline.nvim]], true)
try_loadstring("\27LJ\2\nü\3\0\0\5\0\17\00026\0\0\0009\0\1\0009\0\2\0)\2\0\0'\3\3\0005\4\4\0B\0\4\0016\0\0\0009\0\1\0009\0\2\0)\2\0\0'\3\5\0005\4\6\0B\0\4\0016\0\0\0009\0\1\0009\0\2\0)\2\0\0'\3\a\0005\4\b\0B\0\4\0016\0\0\0009\0\1\0009\0\2\0)\2\0\0'\3\t\0005\4\n\0B\0\4\0016\0\0\0009\0\1\0009\0\2\0)\2\0\0'\3\v\0005\4\f\0B\0\4\0016\0\0\0009\0\1\0009\0\2\0)\2\0\0'\3\r\0005\4\14\0B\0\4\0016\0\0\0009\0\1\0009\0\2\0)\2\0\0'\3\15\0005\4\16\0B\0\4\1K\0\1\0\1\0\1\afg\f#56B6C2\16RainbowCyan\1\0\1\afg\f#C678DD\18RainbowViolet\1\0\1\afg\f#98C379\17RainbowGreen\1\0\1\afg\f#D19A66\18RainbowOrange\1\0\1\afg\f#61AFEF\16RainbowBlue\1\0\1\afg\f#E5C07B\18RainbowYellow\1\0\1\afg\f#E06C75\15RainbowRed\16nvim_set_hl\bapi\bvim‹\1\1\0\5\0\t\0\0156\0\0\0'\2\1\0B\0\2\0029\1\2\0009\3\3\0009\3\4\0033\4\5\0B\1\3\0015\1\6\0006\2\0\0'\4\a\0B\2\2\0029\2\b\2B\2\1\1K\0\1\0\nsetup\bibl\1\b\0\0\15RainbowRed\18RainbowYellow\16RainbowBlue\18RainbowOrange\17RainbowGreen\18RainbowViolet\16RainbowCyan\0\20HIGHLIGHT_SETUP\ttype\rregister\14ibl.hooks\frequire\0", "config", "indent-blankline.nvim")
time([[Config for indent-blankline.nvim]], false)
-- Config for: nvim-colorizer.lua
time([[Config for nvim-colorizer.lua]], true)
try_loadstring("\27LJ\2\n7\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\1\2\0B\1\1\1K\0\1\0\nsetup\14colorizer\frequire\0", "config", "nvim-colorizer.lua")
time([[Config for nvim-colorizer.lua]], false)
-- Config for: nvim-scrollbar
time([[Config for nvim-scrollbar]], true)
try_loadstring("\27LJ\2\n7\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\14scrollbar\frequire\0", "config", "nvim-scrollbar")
time([[Config for nvim-scrollbar]], false)
-- Config for: transparent.nvim
time([[Config for transparent.nvim]], true)
try_loadstring("\27LJ\2\nÈ\2\0\0\4\0\b\0\r6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0024\3\0\0=\3\6\0024\3\0\0=\3\a\2B\0\2\1K\0\1\0\19exclude_groups\17extra_groups\vgroups\1\0\3\17extra_groups\0\vgroups\0\19exclude_groups\0\1\23\0\0\vNormal\rNormalNC\fComment\rConstant\fSpecial\15Identifier\14Statement\fPreProc\tType\15Underlined\tTodo\vString\rFunction\16Conditional\vRepeat\rOperator\14Structure\vLineNr\fNonText\15SignColumn\17CursorLineNr\16EndOfBuffer\nsetup\16transparent\frequire\0", "config", "transparent.nvim")
time([[Config for transparent.nvim]], false)
-- Config for: nvim-treesitter
time([[Config for nvim-treesitter]], true)
try_loadstring("\27LJ\2\nˇ\2\0\0\6\0\15\0\0226\0\0\0'\2\1\0B\0\2\2+\1\2\0=\1\2\0006\0\0\0'\2\3\0B\0\2\0029\1\4\0005\3\6\0005\4\5\0=\4\a\0035\4\b\0004\5\0\0=\5\t\4=\4\n\0035\4\v\0=\4\f\0035\4\r\0=\4\14\3B\1\2\1K\0\1\0\fautotag\1\0\1\venable\2\vindent\1\0\1\venable\2\14highlight\fdisable\1\0\2\venable\2\fdisable\0\21ensure_installed\1\0\4\vindent\0\fautotag\0\21ensure_installed\0\14highlight\0\1\r\0\0\bcss\tfish\thtml\tjava\15javascript\tjson\blua\vpython\btsx\15typescript\bvim\tyaml\nsetup\28nvim-treesitter.configs\15prefer_git\28nvim-treesitter.install\frequire\0", "config", "nvim-treesitter")
time([[Config for nvim-treesitter]], false)
-- Config for: nvim-web-devicons
time([[Config for nvim-web-devicons]], true)
try_loadstring("\27LJ\2\nØ\3\0\0\5\0\16\0\0196\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\6\0005\3\4\0005\4\3\0=\4\5\3=\3\a\0025\3\t\0005\4\b\0=\4\n\3=\3\v\0025\3\r\0005\4\f\0=\4\14\3=\3\15\2B\0\2\1K\0\1\0\26override_by_extension\blog\1\0\1\blog\0\1\0\3\ncolor\f#81e043\tname\bLog\ticon\bÔêé\25override_by_filename\15.gitignore\1\0\1\15.gitignore\0\1\0\3\ncolor\f#f1502f\tname\14Gitignore\ticon\bÓúÇ\roverride\1\0\6\26override_by_extension\0\25override_by_filename\0\vstrict\2\16color_icons\2\roverride\0\fdefault\2\bzsh\1\0\1\bzsh\0\1\0\4\16cterm_color\a65\ncolor\f#428850\tname\bZsh\ticon\bÓûï\nsetup\22nvim-web-devicons\frequire\0", "config", "nvim-web-devicons")
time([[Config for nvim-web-devicons]], false)
-- Config for: hlargs.nvim
time([[Config for hlargs.nvim]], true)
try_loadstring("\27LJ\2\n4\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\vhlargs\frequire\0", "config", "hlargs.nvim")
time([[Config for hlargs.nvim]], false)
-- Config for: gitsigns.nvim
time([[Config for gitsigns.nvim]], true)
try_loadstring("\27LJ\2\n6\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\rgitsigns\frequire\0", "config", "gitsigns.nvim")
time([[Config for gitsigns.nvim]], false)
-- Config for: git.nvim
time([[Config for git.nvim]], true)
try_loadstring("\27LJ\2\n∆\2\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\2B\0\2\1K\0\1\0\fkeymaps\1\0\n\tdiff\15<Leader>ad\24create_pull_request\15<Leader>an\22open_pull_request\15<Leader>ap\vbrowse\15<Leader>af\17blame_commit\t<CR>\15quit_blame\6q\16revert_file\15<Leader>gR\nblame\15<Leader>ao\vrevert\15<Leader>gr\15diff_close\15<Leader>ac\1\0\3\21default_mappings\2\18target_branch\tmain\fkeymaps\0\nsetup\bgit\frequire\0", "config", "git.nvim")
time([[Config for git.nvim]], false)
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
