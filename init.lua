-- File: init.lua

require("config.lazy")
require("config.keymaps")
require("config.autocmds")

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.autoindent = true
vim.opt.termguicolors = true

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2 -- Makes backspace/tab keys behave correctly with 4 spaces
vim.opt.expandtab = true -- Use spaces instead of actual tab characters

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
vim.cmd("colorscheme gruvbox-material")
