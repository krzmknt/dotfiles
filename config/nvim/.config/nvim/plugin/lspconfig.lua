local lspconfig = require("lspconfig")

lspconfig.efm.setup({
  init_options = {
    documentFormatting = true,
    documentRangeFormatting = true,
  },
  settings = {
    rootMarkers = { ".git/" },
    languages = {
      lua = {
        {
          formatCommand = "stylua --color Never --config-path ~/.config/.stylua.toml -",
        },
        {
          lintCommand = "luacheck --no-color --quiet --config ~/.config/.luacheckrc -",
          lintFormats = { "%f:%l:%c: %m" },
        },
      },
      java = {
        {
          lintCommand = "checkstyle -c /path/to/checkstyle.xml",
          lintFormats = { "%f:%l:%c: %m" },
        },
      },
    },
  },
  filetypes = { "lua", "java" },
})



local protocol = require('vim.lsp.protocol')

local augroup_format = vim.api.nvim_create_augroup("Format", { clear = true })

local enable_format_on_save = function(_, bufnr)
  vim.api.nvim_clear_autocmds({ group = augroup_format, buffer = bufnr })
  vim.api.nvim_create_autocmd("BufWritePre", {
    group = augroup_format,
    buffer = bufnr,
    callback = function()
      vim.lsp.buf.format({ bufnr = bufnr })
    end,
  })
end

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local opts = { noremap = true, silent = true }
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
end

protocol.CompletionItemKind = {
  '', -- Color
  '', -- Constant
  '', -- TypeParameter
  '', -- Text
  '', -- Property
  '', -- Field
  '', -- Variable
  '', -- Enum
  '', -- Struct
  '', -- Event
  '', -- Class
  '', -- Folder
  '', -- File
  '', -- EnumMember
  '', -- Unit
  '', -- Reference
  '', -- Constructor
  '', -- Function
  '', -- Method
  '', -- Keyword
  '', -- Value
  '', -- Module
  '﬌', -- Snippet
  'ﬦ', -- Operator
  'ﰮ', -- Interface
}

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    update_in_insert = false,
    virtual_text = {
      spacing = 4,
      prefix = "●"
    },
    severity_sort = true,
  }
)

local signs = {
  Error = " ",
  Warn = " ",
  Hint = " ",
  Info = " ",
}

for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, {
    text = icon,
    texthl = hl,
    numhl = ""
  })
end

vim.diagnostic.config({
  virtual_text = {
    prefix = '●'
  },
  update_in_insert = true,
  float = {
    source = "always", -- Or "if_many"
  },
})
