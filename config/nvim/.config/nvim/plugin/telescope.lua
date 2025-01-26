local status, telescope = pcall(require, "telescope")
if (not status) then return end
local actions = require('telescope.actions')
local builtin = require("telescope.builtin")

local function telescope_buffer_dir()
  return vim.fn.expand('%:p:h')
end

local fb_actions = require "telescope".extensions.file_browser.actions

telescope.setup {
  defaults = {
    mappings = {
      n = {
        ["q"] = actions.close,
        ["c"] = fb_actions.create,
        ["r"] = fb_actions.rename,
        ["m"] = fb_actions.move,
        ["y"] = fb_actions.copy,
        ["d"] = fb_actions.remove,
        ["o"] = fb_actions.open,
        ["g"] = fb_actions.goto_parent_dir,
        ["e"] = fb_actions.goto_home_dir,
        ["w"] = fb_actions.goto_cwd,
        ["t"] = fb_actions.change_cwd,
        ["f"] = fb_actions.toggle_browser,
        ["h"] = fb_actions.toggle_hidden,
        ["s"] = fb_actions.toggle_all,
      },
      i = {
        ["<A-c>"] = fb_actions.create,
        ["<S-CR>"] = fb_actions.create_from_prompt,
        ["<A-r>"] = fb_actions.rename,
        ["<A-m>"] = fb_actions.move,
        ["<A-y>"] = fb_actions.copy,
        ["<A-d>"] = fb_actions.remove,
        ["<C-o>"] = fb_actions.open,
        ["<C-g>"] = fb_actions.goto_parent_dir,
        ["<C-e>"] = fb_actions.goto_home_dir,
        ["<C-w>"] = fb_actions.goto_cwd,
        ["<C-t>"] = fb_actions.change_cwd,
        ["<C-f>"] = fb_actions.toggle_browser,
        ["<C-h>"] = fb_actions.toggle_hidden,
        ["<C-s>"] = fb_actions.toggle_all,
      },
    },
  },
  extensions = {
    file_browser = {
      -- theme = "dropdown",
      theme = "ivy",
      initial_mode = "normal",
      hijack_netrw = true,
      hidden = true,
      mappings = {
        ["i"] = {
          ["<C-w>"] = function() vim.cmd('normal vbd') end,
        },
        ["n"] = {
          ["N"] = fb_actions.create,
          ["h"] = fb_actions.goto_parent_dir,
          ["/"] = function()
            vim.cmd('startinsert')
          end
        },
      },
    },
  },
}

telescope.load_extension("file_browser")

vim.keymap.set('n', ';f',
  function()
    builtin.find_files({
      no_ignore = false,
      hidden = true
    })
  end)

vim.keymap.set('n', '\\\\', function()
  builtin.buffers()
end)

vim.keymap.set('n', ';t', function()
  builtin.help_tags()
end)

vim.keymap.set('n', ';;', function()
  builtin.resume()
end)

vim.keymap.set('n', ';e', function()
  builtin.diagnostics()
end)

-- vim.keymap.set("n", "sf", function()
--   telescope.extensions.file_browser.file_browser({
--     path = "%:p:h",
--     cwd = telescope_buffer_dir(),
--     respect_gitignore = false,
--     hidden = true,
--     grouped = true,
--     previewer = false,
--     initial_mode = "normal",
--     layout_config = { height = 100 }
--   })
-- end)
