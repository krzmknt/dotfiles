require("notify").setup({
  background_colour = "#1f2335", -- 背景色を指定 (ここでは少し暗い色を設定)
})

-- require("noice").setup({
--   lsp = {
--     -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
--     override = {
--       ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
--       ["vim.lsp.util.stylize_markdown"] = true,
--       ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
--     },
--   },
--   -- you can enable a preset for easier configuration
--   presets = {
--     bottom_search = true,         -- use a classic bottom cmdline for search
--     command_palette = true,       -- position the cmdline and popupmenu together
--     long_message_to_split = true, -- long messages will be sent to a split
--     inc_rename = false,           -- enables an input dialog for inc-rename.nvim
--     lsp_doc_border = false,       -- add a border to hover docs and signature help
--   },
-- })

local noice = require("noice")

local function myMiniView(pattern, kind)
  kind = kind or ""
  return {
    view = "mini",
    filter = {
      event = "msg_show",
      kind = kind,
      find = pattern,
    },
  }
end

noice.setup({
  messages = {
    view_search = "mini",
  },

  routes = {
    {
      view = "notify",
      filter = { event = "msg_showmode" },
    },

    {
      filter = {
        event = "notify",
        warning = true,
        find = "failed to run generator.*is not executable",
      },
      opts = { skip = true },
    },

    myMiniView("INSERT"),
    myMiniView("Already at .* change"),
    myMiniView("written"),
    myMiniView("yanked"),
    myMiniView("more lines?"),
    myMiniView("fewer lines?"),
    myMiniView("fewer lines?", "lua_error"),
    myMiniView("change; before"),
    myMiniView("change; after"),
    myMiniView("line less"),
    myMiniView("lines indented"),
    myMiniView("No lines in buffer"),
    myMiniView("search hit .*, continuing at", "wmsg"),
    myMiniView("E486: Pattern not found", "emsg"),
  },
})
