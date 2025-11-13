return {
  -- Mason: LSP installer
  {
    "williamboman/mason.nvim",
    lazy = false,
    priority = 100,
    config = function()
      require("mason").setup()
    end,
  },

  -- Mason-lspconfig: Bridge between mason and lspconfig
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
      "hrsh7th/cmp-nvim-lsp",  -- Need this for capabilities
    },
    lazy = false,
    priority = 50,
    config = function()
      print("[LSP] mason-lspconfig config function called")

      -- Get capabilities for nvim-cmp integration
      local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
      local capabilities = has_cmp and cmp_nvim_lsp.default_capabilities() or vim.lsp.protocol.make_client_capabilities()

      -- Common on_attach function for keybindings
      local on_attach = function(client, bufnr)
        -- Debug: Confirm on_attach is called
        print(string.format("[LSP] on_attach called for %s (buffer %d)", client.name, bufnr))

        local opts = { buffer = bufnr, silent = true }

        -- GoTo code navigation
        vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, opts)
        print("[LSP] Set keymap: gy")
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)

        -- Go to definition with tab drop (like coc.nvim)
        vim.keymap.set("n", "gd", function()
          -- Save current position to jump list
          vim.cmd("normal! m'")

          local params = vim.lsp.util.make_position_params()
          vim.lsp.buf_request(0, 'textDocument/definition', params, function(err, result, ctx, config)
            if err then
              vim.notify("LSP Error: " .. tostring(err), vim.log.levels.ERROR)
              return
            end

            if not result or vim.tbl_isempty(result) then
              vim.notify("No definition found", vim.log.levels.WARN)
              return
            end

            -- Handle both single result and array of results
            local location = vim.tbl_islist(result) and result[1] or result
            local uri = location.uri or location.targetUri
            local range = location.range or location.targetRange

            if not uri or not range then
              vim.notify("Invalid definition location", vim.log.levels.ERROR)
              return
            end

            -- Convert URI to file path
            local fname = vim.uri_to_fname(uri)

            -- Use tab drop to open in a tab (or switch to existing tab)
            vim.cmd("tab drop " .. vim.fn.fnameescape(fname))

            -- Jump to the position
            local pos = range.start
            vim.api.nvim_win_set_cursor(0, {pos.line + 1, pos.character})

            -- Center the screen on the cursor
            vim.cmd("normal! zz")
          end)
        end, opts)
        print("[LSP] Set keymap: gd")

        -- Show documentation (override Vim's default ? backward search)
        vim.keymap.set("n", "?", vim.lsp.buf.hover, opts)
        print("[LSP] Set keymap: ?")
        vim.keymap.set("n", "gh", vim.lsp.buf.hover, opts)  -- Alternative: gh
        print("[LSP] Set keymap: gh")

        -- Diagnostics navigation
        vim.keymap.set("n", "g<", vim.diagnostic.goto_prev, opts)
        vim.keymap.set("n", "g>", vim.diagnostic.goto_next, opts)

        -- Rename
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

        -- Code action
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)

        -- Format
        vim.keymap.set("n", "<leader>f", function()
          vim.lsp.buf.format({ async = true })
        end, opts)

        -- Highlight symbol under cursor
        if client.server_capabilities.documentHighlightProvider then
          vim.api.nvim_create_augroup("lsp_document_highlight", { clear = false })
          vim.api.nvim_clear_autocmds({ buffer = bufnr, group = "lsp_document_highlight" })
          vim.api.nvim_create_autocmd("CursorHold", {
            group = "lsp_document_highlight",
            buffer = bufnr,
            callback = vim.lsp.buf.document_highlight,
          })
          vim.api.nvim_create_autocmd("CursorMoved", {
            group = "lsp_document_highlight",
            buffer = bufnr,
            callback = vim.lsp.buf.clear_references,
          })
        end

        print(string.format("[LSP] on_attach completed for %s", client.name))
      end

      -- Setup mason-lspconfig with handlers passed directly to setup()
      print("[LSP] About to call mason-lspconfig.setup()")
      local ok, err = pcall(function()
        require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",           -- Lua
          "gopls",            -- Go
          "bashls",           -- Bash
          "pyright",          -- Python
          "jdtls",            -- Java
          "rust_analyzer",    -- Rust
          "tailwindcss",      -- Tailwind CSS
          "ts_ls",            -- TypeScript/JavaScript
        },
        automatic_installation = true,
        handlers = {
        -- Default handler for all servers
        function(server_name)
          print(string.format("[LSP] Setting up server: %s", server_name))
          require("lspconfig")[server_name].setup({
            capabilities = capabilities,
            on_attach = on_attach,
          })
          print(string.format("[LSP] Server setup completed: %s", server_name))
        end,

        -- Custom handler for Lua
        ["lua_ls"] = function()
          require("lspconfig").lua_ls.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {
              Lua = {
                diagnostics = {
                  globals = { "vim" },
                },
              },
            },
          })
        end,

        -- Custom handler for Python
        ["pyright"] = function()
          require("lspconfig").pyright.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {
              python = {
                analysis = {
                  typeCheckingMode = "basic",
                  autoSearchPaths = true,
                  useLibraryCodeForTypes = true,
                },
              },
            },
          })
        end,

        -- Custom handler for Rust
        ["rust_analyzer"] = function()
          require("lspconfig").rust_analyzer.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {
              ["rust-analyzer"] = {
                checkOnSave = {
                  command = "clippy",
                },
                cargo = {
                  loadOutDirsFromCheck = true,
                },
                procMacro = {
                  enable = true,
                },
              },
            },
          })
        end,
        },  -- Close handlers table
      })    -- Close setup() call
      end)

      if not ok then
        vim.notify("[LSP] Error in mason-lspconfig.setup: " .. tostring(err), vim.log.levels.ERROR)
      else
        print("[LSP] mason-lspconfig setup completed successfully")
      end

      -- Diagnostic configuration
      vim.diagnostic.config({
        virtual_text = {
          spacing = 4,
          prefix = "●",
          source = "if_many",
          -- Format function to remove duplicate messages
          format = function(diagnostic)
            return diagnostic.message
          end,
        },
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.HINT] = "",
            [vim.diagnostic.severity.INFO] = "",
          },
        },
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = {
          source = "always",
          border = "rounded",
          header = "",
          prefix = "",
        },
      })

      -- Set diagnostic highlight colors to be more visible
      vim.cmd([[
        highlight DiagnosticError guifg=#E06C75 gui=bold
        highlight DiagnosticWarn guifg=#E5C07B gui=bold
        highlight DiagnosticInfo guifg=#61AFEF gui=bold
        highlight DiagnosticHint guifg=#56B6C2 gui=bold
        highlight DiagnosticVirtualTextError guifg=#E06C75 gui=bold
        highlight DiagnosticVirtualTextWarn guifg=#E5C07B gui=bold
        highlight DiagnosticVirtualTextInfo guifg=#61AFEF gui=bold
        highlight DiagnosticVirtualTextHint guifg=#56B6C2 gui=bold
      ]])

      -- Global settings
      vim.opt.updatetime = 300
      vim.opt.signcolumn = "yes"  -- Show sign column (diagnostic icons will appear left of line numbers)

      -- User commands
      vim.api.nvim_create_user_command("Format", function()
        vim.lsp.buf.format({ async = true })
      end, {})

      vim.api.nvim_create_user_command("OR", function()
        vim.lsp.buf.code_action({
          context = { only = { "source.organizeImports" } },
          apply = true,
        })
      end, {})
    end,
  },

  -- Completion plugin: nvim-cmp
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",     -- LSP source
      "hrsh7th/cmp-buffer",        -- Buffer source
      "hrsh7th/cmp-path",          -- Path source
      "hrsh7th/cmp-cmdline",       -- Cmdline source
      "L3MON4D3/LuaSnip",          -- Snippet engine
      "saadparwaiz1/cmp_luasnip",  -- Snippet source
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          -- Arrow keys for navigation (matching your coc config)
          ["<Down>"] = cmp.mapping.select_next_item(),
          ["<Up>"] = cmp.mapping.select_prev_item(),

          -- Enter to confirm (matching your coc config)
          ["<CR>"] = cmp.mapping.confirm({ select = true }),

          -- Ctrl+Space to trigger completion (matching your coc config)
          ["<C-Space>"] = cmp.mapping.complete(),

          -- Ctrl+j for snippets (matching your coc config)
          ["<C-j>"] = cmp.mapping(function(fallback)
            if luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),

          -- Scroll documentation
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        }),
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
      })

      -- Command line completion
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline" },
        }),
      })
    end,
  },

  -- LuaSnip: Snippet engine
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp",
  },

  -- none-ls: Formatter and Linter integration (null-ls successor)
  {
    "nvimtools/none-ls.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      local null_ls = require("null-ls")

      null_ls.setup({
        sources = {
          -- Prettier for formatting
          null_ls.builtins.formatting.prettierd.with({
            filetypes = {
              "javascript",
              "javascriptreact",
              "typescript",
              "typescriptreact",
              "vue",
              "css",
              "scss",
              "less",
              "html",
              "json",
              "jsonc",
              "yaml",
              "markdown",
              "graphql",
              "handlebars",
            },
          }),
        },
        on_attach = function(client, bufnr)
          if client.supports_method("textDocument/formatting") then
            -- Auto-format on save
            local augroup = vim.api.nvim_create_augroup("LspFormatting", { clear = false })
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
              group = augroup,
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format({ bufnr = bufnr })
              end,
            })
          end
        end,
      })
    end,
  },
}
