-- File: lua/plugins/lsp.lua

return {

  -- Tool Installer
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "pyright",   -- Python LSP
        "ruff",      -- Python Linter/Formatter
        "gopls",     -- Go Language Server
        "gofumpt",   -- Stricter Go Formatter
        "goimports", -- Automatically fixes imports
        -- START: C/C++ Additions for Mason
        "clangd",    -- C/C++ Language Server
        "clang-format", -- C/C++ Formatter
        -- END: C/C++ Additions for Mason
      },
    },
    config = function(_, opts)
      require("mason").setup(opts)
    end,
  },

  -- LSP Configuration
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      -- 1. Setup the common "on_attach" function
      local on_attach = function(client, bufnr)
        -- ... (Your existing keymaps)
        local nmap = function(keys, func, desc)
          if desc then desc = "LSP: " .. desc end
          vim.keymap.set("n", keys, func, { buffer = bufnr, noremap = true, silent = true, desc = desc })
        end

        nmap("gd", vim.lsp.buf.definition, "Go to Definition")
        nmap("K", vim.lsp.buf.hover, "Hover Documentation")
        nmap("gi", vim.lsp.buf.implementation, "Go to Implementation")
        nmap("gr", vim.lsp.buf.references, "Find References")
        nmap("<leader>rn", vim.lsp.buf.rename, "Rename Symbol")
        nmap("<leader>ca", vim.lsp.buf.code_action, "Code Action")
        nmap("<leader>e", vim.diagnostic.open_float, "Show Diagnostics")
      end

      -- 2. Setup capabilities for autocompletion
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- 3. Configure mason-lspconfig
      require("mason-lspconfig").setup({
        -- Add "clangd" to the list of LSPs to be configured
        ensure_installed = { "pyright", "gopls", "ts_ls", "clangd" },
        handlers = {
          -- Default handler (optional, but good practice)
          function(server_name)
            require("lspconfig")[server_name].setup({
              on_attach = on_attach,
              capabilities = capabilities,
            })
          end,

          -- Explicit handler for pyright
          ["pyright"] = function()
            require("lspconfig").pyright.setup({
              on_attach = on_attach,
              capabilities = capabilities,
            })
          end,

          ["gopls"] = function()
            require("lspconfig").gopls.setup({
              on_attach = on_attach,
              capabilities = capabilities,
              settings = {
                gopls = {
                  -- These settings are highly recommended for Go
                  completeUnimported = true,
                  usePlaceholders = true,
                  analyses = {
                    unusedparams = true,
                  },
                },
              },
            })
          end,

          ["ts_ls"] = function()
            require("lspconfig").tl_ls.setup({
              on_attach = on_attach,
              capabilities = capabilities,
              settings = {
                telemetry = {
                  enable = false,
                },
              },
            })
          end,

          -- START: Explicit handler for clangd
          ["clangd"] = function()
            require("lspconfig").clangd.setup({
              on_attach = on_attach,
              capabilities = capabilities,
              settings = {
              -- clangd = {
              --   fallbackFlags = {
              --     "-xc++",                    -- Treat files as C++
              --     "-std=c++20",               -- Use C++20 standard
              --     -- This is the CRITICAL line: Tell clangd to query the exact g++ compiler
              --     -- when no compile database is found.
              --     "--query-driver=C:/msys64/ucrt64/bin/g++.exe",
              --   },
              -- },
            },
          })
          end,
          -- END: Explicit handler for clangd
        },
      })
    end,
  },

  -- Autocompletion
  -- ... (No changes needed for the autocompletion section)
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
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
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        }),
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
      })
    end,
  },
}
