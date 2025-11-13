return {
  -- Mason: LSP installer
  {
    "williamboman/mason.nvim",
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
    },
    config = function()
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
      })

      -- Get capabilities for nvim-cmp integration
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Common on_attach function for keybindings
      local on_attach = function(client, bufnr)
        local opts = { buffer = bufnr, silent = true }

        -- GoTo code navigation
        vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, opts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)

        -- Show documentation
        vim.keymap.set("n", "?", vim.lsp.buf.hover, opts)

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
      end

      -- Setup handlers for all servers
      require("mason-lspconfig").setup_handlers({
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
      })

      -- Diagnostic configuration
      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
      })

      -- Diagnostic signs with Nerd Font icons
      local signs = {
        Error = "", -- Nerd Font icon
        Warn = "",  -- Nerd Font icon
        Hint = "",  -- Nerd Font icon
        Info = ""   -- Nerd Font icon
      }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end

      -- Global settings
      vim.opt.updatetime = 300
      vim.opt.signcolumn = "yes"

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
}
