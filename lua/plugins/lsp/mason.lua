
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
  }
}
