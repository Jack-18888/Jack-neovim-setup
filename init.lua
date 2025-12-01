-- File: init.lua

vim.opt.termguicolors = true

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

vim.opt.clipboard = "unnamedplus" -- Use system clipboard
-- Explicitly configure the clipboard provider for WSL
if vim.fn.has("wsl") == 1 then
  vim.g.clipboard = {
    name = "win32yank-wsl",
    copy = {
      ["+"] = "win32yank.exe -i --crlf",
      ["*"] = "win32yank.exe -i --crlf",
    },
    paste = {
      ["+"] = "win32yank.exe -o --lf",
      ["*"] = "win32yank.exe -o --lf",
    },
    cache_enabled = 0,
  }
end 

vim.opt.foldenable = true -- Disable code folding by default

-- Set default colorscheme 
vim.cmd("colorscheme gruvbox-material")

