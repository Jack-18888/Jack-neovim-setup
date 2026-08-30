
return {
  -- Tool Installer
  {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonUpdate", "MasonLog", "MasonUninstall", "MasonUninstallAll" },
    event = "VeryLazy",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
    },
    opts = {
      ensure_installed = {
        "pyright",   -- Python LSP
        "ruff",      -- Python Linter/Formatter
        "gopls",     -- Go Language Server
        "gofumpt",   -- Stricter Go Formatter
        "goimports", -- Automatically fixes imports
        "clangd",    -- C/C++ Language Server
        "clang-format", -- C/C++ Formatter
      },
    },
    config = function(_, opts)
      require("mason").setup(opts)
      require("mason-lspconfig").setup({
        ensure_installed = { "pyright", "gopls", "clangd" },
        automatic_enable = false,
      })
    end,
  }
}
