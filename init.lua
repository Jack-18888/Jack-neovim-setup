-- File: init.lua

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

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2 -- Makes backspace/tab keys behave correctly with 4 spaces
vim.opt.expandtab = true -- Use spaces instead of actual tab characters
vim.opt.swapfile = false

vim.opt.number = true -- Good to have
vim.opt.scrolloff = 8 -- Keep 8 lines visible when scrolling

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.o.clipboard = "unnamedplus" -- Use system clipboard

vim.opt.foldenable = true -- Disable code folding by default

-- Set highlight groups
vim.api.nvim_set_hl(0, "@variable", { fg = "#ddffe1" })
vim.api.nvim_set_hl(0, "String", { fg = "#61bd6b" })

-- Set default colorscheme 
vim.cmd("colorscheme tokyonight")

-- Set custom coloring
-- vim.api.nvim_set_hl(0, "Variable", { fg = "#abc7de" })
-- vim.api.nvim_set_hl(0, "Constant", { fg = "#83afd4" })
-- vim.api.nvim_set_hl(0, "@lsp.type.variable.cpp", { link = "Variable" })
-- vim.api.nvim_set_hl(0, "@lsp.type.parameter.cpp", { link = "Variable" })
-- vim.api.nvim_set_hl(0, "@lsp.mod.readonly.cpp", { link = "Constant" })
