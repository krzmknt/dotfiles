local null_ls = require('null-ls')

null_ls.setup({
  sources = {

    -- formatting
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.diagnostics.eslint,
    null_ls.builtins.completion.spell,

    -- python
    -- null_ls.builtins.diagnostics.pylint,
    -- null_ls.builtins.formatting.black,
    -- null_ls.builtins.formatting.isort,

    -- markdown
    null_ls.builtins.diagnostics.markdownlint,

    -- CSS
    null_ls.builtins.formatting.prettierd,
    null_ls.builtins.diagnostics.stylelint,
  },
})
