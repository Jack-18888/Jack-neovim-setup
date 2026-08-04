
return {
  -- LSP Configuration
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local on_attach = function(client, bufnr)
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

      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      require("mason-lspconfig").setup({
        ensure_installed = { "pyright", "gopls", "clangd" },
        automatic_enable = false,
      })

      vim.lsp.config("pyright", {
        on_attach = on_attach,
        capabilities = capabilities,
      })

          ["clangd"] = function()
            require("lspconfig").clangd.setup({
              on_attach = on_attach,
              capabilities = capabilities,
              cmd = {
                "clangd",
                "--background-index",
                "--clang-tidy",
                "--header-insertion=iwyu",
                "--completion-style=detailed",
                "--function-arg-placeholders",
                "--fallback-style=llvm",
              },
              init_options = {
                usePlaceholders = true,
                completeUnimported = true,
                clangdFileStatus = true,
              },
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

          -- START: Explicit handler for clangd
          ["clangd"] = function()
            require("lspconfig").clangd.setup({
              on_attach = on_attach,
              capabilities = capabilities,
              settings = {
            },
          },
        },
      })

      vim.lsp.config("clangd", {
        cmd = { "C:\\msys64\\ucrt64\\bin\\clangd.exe" },
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
        },
      })

      vim.lsp.enable("pyright")
      vim.lsp.enable("gopls")
      vim.lsp.enable("clangd")
    end,
  }
}
