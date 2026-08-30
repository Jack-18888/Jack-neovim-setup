
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
      if vim.fn.has("win32") == 1 then
        local win_python = "C:/Users/T14G3/AppData/Local/Python/pythoncore-3.14-64"
        if not vim.env.PATH:find("pythoncore-3.14-64", 1, true) then
          vim.env.PATH = win_python .. ";" .. vim.env.PATH
        end
      end
      require("mason").setup(opts)
      require("mason-lspconfig").setup({
        ensure_installed = { "pyright", "gopls", "clangd" },
        automatic_enable = false,
      })
    end,
  }
}
