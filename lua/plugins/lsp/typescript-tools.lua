
return {
  {
    "pmizio/typescript-tools.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    config = function()
      -- 1. Define the on_attach function with your keymaps
      local on_attach = function(client, bufnr)
        local nmap = function(keys, func, desc)
          vim.keymap.set("n", keys, func, { buffer = bufnr, noremap = true, silent = true, desc = "LSP: " .. desc })
        end

        nmap("gd", vim.lsp.buf.definition, "Go to Definition")
        nmap("K", vim.lsp.buf.hover, "Hover Documentation")
        nmap("gi", vim.lsp.buf.implementation, "Go to Implementation")
        nmap("gr", vim.lsp.buf.references, "Find References")
        nmap("<leader>rn", vim.lsp.buf.rename, "Rename Symbol")
        nmap("<leader>ca", vim.lsp.buf.code_action, "Code Action")
        nmap("<leader>e", vim.diagnostic.open_float, "Show Diagnostics")
      end

      -- 2. Setup the plugin with the on_attach function
      require("typescript-tools").setup({
        on_attach = on_attach,
        settings = {
          -- spawn additional tsserver processes for faster response
          separate_diagnostic_server = true,
          -- publish diagnostics on typing
          publish_diagnostic_on = "insert_leave",
        },
      })
    end,
  },
}
