
return {
  -- Tool Installer
  {
    "williamboman/mason.nvim",
    event = "VeryLazy",
    opts = {
      ensure_installed = {
        "pyright",   -- Python LSP
        "ruff",      -- Python Linter/Formatter
        "clangd",    -- C/C++ Language Server
        "clang-format", -- C/C++ Formatter
      },
    },
    config = function(_, opts)
      require("mason").setup(opts)
    end,
  }
}
