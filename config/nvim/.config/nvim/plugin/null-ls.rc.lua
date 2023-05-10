local null_ls = require("null-ls")

null_ls.setup({
  sources = {

    -- formatting
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.diagnostics.eslint,
    null_ls.builtins.completion.spell,

    -- python
    null_ls.builtins.formatting.autopep8,
    -- null_ls.builtins.formatting.black,
    -- null_ls.builtins.formatting.isort,
    -- null_ls.builtins.diagnostics.flake8,
    null_ls.builtins.diagnostics.pylint,

    -- markdown
    null_ls.builtins.diagnostics.markdownlint,

    -- CSS
    null_ls.builtins.formatting.prettierd,
    null_ls.builtins.diagnostics.stylelint,



  },
})
