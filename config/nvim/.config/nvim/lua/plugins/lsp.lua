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
      -- Get capabilities for nvim-cmp integration
      local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
      local capabilities = has_cmp and cmp_nvim_lsp.default_capabilities() or vim.lsp.protocol.make_client_capabilities()

      -- Load icons and colors from util modules
      local icons = require("util.icons")
      local colors = require("util.color")

      -- Common on_attach function for keybindings
      local on_attach = function(client, bufnr)
        local opts = { buffer = bufnr, silent = true }

        -- GoTo code navigation
        vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, opts)
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

        -- Show documentation
        vim.keymap.set("n", "gK", vim.lsp.buf.hover, opts)  -- g + Shift+k for hover
        vim.keymap.set("n", "gH", vim.lsp.buf.hover, opts)  -- Alternative: g + Shift+h

        -- Diagnostics navigation
        vim.keymap.set("n", "g<", vim.diagnostic.goto_prev, opts)
        vim.keymap.set("n", "g>", vim.diagnostic.goto_next, opts)

        -- Rename
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

        -- Code action
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)

        -- Format
        vim.keymap.set("n", "<leader>f", function()
          vim.lsp.buf.format({
            async = true,
            filter = function(client)
              -- Prefer null-ls for formatting
              return client.name == "null-ls"
            end,
          })
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
      end

      -- Setup mason-lspconfig
      local mason_lspconfig = require("mason-lspconfig")

      local ok, err = pcall(function()
        mason_lspconfig.setup({
        ensure_installed = {
          "lua_ls",           -- Lua
          "bashls",           -- Bash
          "pyright",          -- Python
          "jdtls",            -- Java
          "rust_analyzer",    -- Rust
          "tailwindcss",      -- Tailwind CSS
          "ts_ls",            -- TypeScript/JavaScript
          "cssls",            -- CSS
          "html",             -- HTML
          "jsonls",           -- JSON
          "eslint",           -- ESLint
        },
        automatic_installation = true,
        handlers = {
        -- Default handler for all servers
        function(server_name)
          require("lspconfig")[server_name].setup({
            capabilities = capabilities,
            on_attach = on_attach,
          })
        end,

        -- Custom handler for Lua
        ["lua_ls"] = function()
          require("lspconfig").lua_ls.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {
              Lua = {
                runtime = {
                  version = "LuaJIT",
                },
                diagnostics = {
                  globals = { "vim" },
                  -- Disable specific diagnostics
                  disable = { "missing-fields", "incomplete-signature-doc" },
                },
                workspace = {
                  library = vim.api.nvim_get_runtime_file("", true),
                  checkThirdParty = false,
                },
                telemetry = {
                  enable = false,
                },
                format = {
                  enable = true,
                  defaultConfig = {
                    indent_style = "space",
                    indent_size = "2",
                  }
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

        -- Custom handler for TypeScript (disable if Deno is detected)
        ["ts_ls"] = function()
          local lspconfig = require("lspconfig")
          lspconfig.ts_ls.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            root_dir = lspconfig.util.root_pattern("package.json"),
            single_file_support = false,
          })
        end,

        -- Custom handler for ESLint
        ["eslint"] = function()
          require("lspconfig").eslint.setup({
            capabilities = capabilities,
            on_attach = on_attach,
          })
        end,

        -- Disable deno-ls
        ["denols"] = function()
          -- Do nothing - prevent deno-ls from starting
        end,
        },  -- Close handlers
      })    -- Close setup()
      end)  -- Close pcall

      if not ok then
        vim.notify("[LSP] Error in mason-lspconfig.setup: " .. tostring(err), vim.log.levels.ERROR)
        return
      end

      -- Prevent deno-ls from attaching to buffers
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client and client.name == "denols" then
            vim.lsp.stop_client(client.id)
          end
        end,
      })

      -- Filter out deno-lint diagnostics globally
      local original_handler = vim.lsp.handlers["textDocument/publishDiagnostics"]
      vim.lsp.handlers["textDocument/publishDiagnostics"] = function(err, result, ctx, config)
        if result and result.diagnostics then
          result.diagnostics = vim.tbl_filter(function(diagnostic)
            return diagnostic.source ~= "deno-lint"
          end, result.diagnostics)
        end
        original_handler(err, result, ctx, config)
      end

      -- Configure LSP floating windows with fancy borders
      local border_chars = {
        { "╭", "FloatBorder" },
        { "─", "FloatBorder" },
        { "╮", "FloatBorder" },
        { "│", "FloatBorder" },
        { "╯", "FloatBorder" },
        { "─", "FloatBorder" },
        { "╰", "FloatBorder" },
        { "│", "FloatBorder" },
      }

      -- Override LSP handlers to use fancy borders
      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = border_chars,
        max_width = 80,
        max_height = 20,
      })

      vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = border_chars,
      })

      -- Diagnostic configuration (Neovim 0.11+ compatible)
      vim.diagnostic.config({
        virtual_text = false,  -- Disable inline diagnostic messages
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = icons.diagnostic.error,
            [vim.diagnostic.severity.WARN] = icons.diagnostic.warn,
            [vim.diagnostic.severity.HINT] = icons.diagnostic.hint,
            [vim.diagnostic.severity.INFO] = icons.diagnostic.info,
          },
        },
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = {
          source = "always",
          border = border_chars,  -- Use fancy rounded borders
          header = "",
          prefix = "",
          -- Filter out deno-lint diagnostics
          format = function(diagnostic)
            if diagnostic.source == "deno-lint" then
              return nil
            end
            return diagnostic.message
          end,
        },
      })

      -- Set diagnostic highlight colors to be more visible
      vim.api.nvim_set_hl(0, "DiagnosticError", { fg = colors.diagnostic.error, bold = true })
      vim.api.nvim_set_hl(0, "DiagnosticWarn", { fg = colors.diagnostic.warn, bold = true })
      vim.api.nvim_set_hl(0, "DiagnosticInfo", { fg = colors.diagnostic.info, bold = true })
      vim.api.nvim_set_hl(0, "DiagnosticHint", { fg = colors.diagnostic.hint, bold = true })
      vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", { fg = colors.diagnostic.error, bold = true })
      vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn", { fg = colors.diagnostic.warn, bold = true })
      vim.api.nvim_set_hl(0, "DiagnosticVirtualTextInfo", { fg = colors.diagnostic.info, bold = true })
      vim.api.nvim_set_hl(0, "DiagnosticVirtualTextHint", { fg = colors.diagnostic.hint, bold = true })
      vim.api.nvim_set_hl(0, "DiagnosticSignError", { fg = colors.diagnostic.error, bold = true })
      vim.api.nvim_set_hl(0, "DiagnosticSignWarn", { fg = colors.diagnostic.warn, bold = true })
      vim.api.nvim_set_hl(0, "DiagnosticSignInfo", { fg = colors.diagnostic.info, bold = true })
      vim.api.nvim_set_hl(0, "DiagnosticSignHint", { fg = colors.diagnostic.hint, bold = true })

      -- Show diagnostics in floating window on CursorHold
      vim.api.nvim_create_autocmd("CursorHold", {
        callback = function()
          local opts = {
            focusable = false,
            close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
            border = "none",
            source = "always",
            prefix = " ",
            scope = "cursor",
          }
          vim.diagnostic.open_float(nil, opts)
        end
      })

      -- Global settings
      vim.opt.updatetime = 100  -- Changed to 100ms for faster popup display
      vim.opt.signcolumn = "yes"  -- Show sign column (diagnostic icons will appear left of line numbers)

      -- User commands
      vim.api.nvim_create_user_command("Format", function()
        vim.lsp.buf.format({
          async = true,
          filter = function(client)
            -- Prefer null-ls for formatting
            return client.name == "null-ls"
          end,
        })
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
          completion = {
            border = "none",
            winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None",
          },
          documentation = {
            border = "none",
          },
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
          -- Stylua for Lua formatting
          null_ls.builtins.formatting.stylua,
        },
        on_attach = function(client, bufnr)
          if client.supports_method("textDocument/formatting") then
            -- Auto-format on save (only use null-ls/none-ls formatters)
            local augroup = vim.api.nvim_create_augroup("LspFormatting", { clear = false })
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
              group = augroup,
              buffer = bufnr,
              callback = function()
                -- Suppress the Neovim 0.11.3 LSP sync.lua error
                pcall(function()
                  vim.lsp.buf.format({
                    bufnr = bufnr,
                    filter = function(formatting_client)
                      -- Only use null-ls for formatting
                      return formatting_client.name == "null-ls"
                    end,
                  })
                end)
              end,
            })
          end
        end,
      })
    end,
  },
}
