
return {
  -- Tool Installer
  {
    "williamboman/mason.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      ensure_installed = {
        "pyright",   -- Python LSP
        "ruff",      -- Python Linter/Formatter
        "gopls",     -- Go Language Server
        "gofumpt",   -- Stricter Go Formatter
        "goimports", -- Automatically fixes imports
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
    end,
  }
}
