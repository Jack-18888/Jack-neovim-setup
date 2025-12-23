
return {
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
  }
}
