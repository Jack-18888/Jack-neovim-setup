-- File: init.lua

-- Enable byte-code caching loader for faster startup
vim.loader.enable()

-- Add MSYS2 UCRT64 toolchain to PATH (gcc for tree-sitter parser builds, clangd, etc.)
if vim.fn.has("win32") == 1 then
  local msys2_bin = "D:/msys64/ucrt64/bin"
  if not vim.env.PATH:find("msys64\\ucrt64\\bin", 1, true)
    and not vim.env.PATH:find("msys64/ucrt64/bin", 1, true) then
    vim.env.PATH = msys2_bin .. ";" .. vim.env.PATH
  end
  vim.env.CC = "gcc"
end

require("config.lazy")
require("config.keymaps")
require("config.autocmds")

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.autoindent = true
vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.opt.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50"
vim.opt.guifont = "JetBrainsMono Nerd Font:h10:b"
vim.opt.signcolumn = "yes"

vim.opt.swapfile = false

vim.opt.number = true -- Good to have
vim.opt.scrolloff = 8 -- Keep 8 lines visible when scrolling

vim.opt.splitright = true
vim.opt.splitbelow = true

-- defer setting clipboard until after plugins are loaded to avoid conflicts with plugin clipboard settings
vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    vim.opt.clipboard = "unnamedplus" -- Use system clipboard
  end,
})

-- Set highlight groups
-- vim.api.nvim_set_hl(0, "@variable", { fg = "#ddffe1" })
-- vim.api.nvim_set_hl(0, "String", { fg = "#61bd6b" })

-- Set default colorscheme 
vim.cmd("colorscheme catppuccin-frappe")

-- Set custom coloring
-- vim.api.nvim_set_hl(0, "Variable", { fg = "#abc7de" })
-- vim.api.nvim_set_hl(0, "Constant", { fg = "#83afd4" })
-- vim.api.nvim_set_hl(0, "@lsp.type.variable.cpp", { link = "Variable" })
-- vim.api.nvim_set_hl(0, "@lsp.type.parameter.cpp", { link = "Variable" })
-- vim.api.nvim_set_hl(0, "@lsp.mod.readonly.cpp", { link = "Constant" })
