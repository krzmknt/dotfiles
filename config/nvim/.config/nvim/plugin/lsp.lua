local pluginLoader = require("util.pluginLoader")

local mason = pluginLoader.load({ pluginName = "mason", enable = false })
if mason == nil then return end

local null_ls = pluginLoader.load({ pluginName = "null_ls", enable = false })
if null_ls == nil then return end

mason.setup()
require("mason-null-ls").setup({
  ensure_installed = { "ruff" },
  automatic_installation = true,
})

null_ls.setup({
  sources = {
    -- リンターとして ruff を使う
    null_ls.builtins.diagnostics.ruff,

    -- フォーマッターとして ruff を使う (オートフィックス機能)
    -- ※ ruff がバージョンによって対応する・しないがあるので要注意
    null_ls.builtins.formatting.ruff,

    -- 他に使いたいツールがあれば追加
    -- null_ls.builtins.formatting.black,
    -- null_ls.builtins.diagnostics.mypy,
  },
})
