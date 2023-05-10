require('mason').setup()
require('mason-lspconfig').setup_handlers({
  function(server)
    local opt = {
      -- Function executed when the LSP server startup
      on_attach = function(client, bufnr)
        local opts = {
          noremap = true,
          silent = true
        }
        vim.cmd 'autocmd BufWritePre * lua vim.lsp.buf.format(nil, 1000)'
      end,
      capabilities = require('cmp_nvim_lsp').default_capabilities(
        vim.lsp.protocol.make_client_capabilities()
      )
    }
    require('lspconfig')[server].setup(opt)
  end
})
