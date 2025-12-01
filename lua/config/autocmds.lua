-- Create a group to prevent duplication
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup("CustomIndent", { clear = true })

autocmd("FileType", {
  group = augroup,
  pattern = "python",
  callback = function()
    vim.opt_local.expandtab = true   -- Use spaces instead of tabs
    vim.opt_local.shiftwidth = 4     -- Size of an indent
    vim.opt_local.tabstop = 4        -- Number of spaces tabs count for
    vim.opt_local.softtabstop = 4
  end,
})

-- Go standards dictate real tabs, not spaces. 
-- We set tabstop to 4 so it looks like 4 spaces visually.
autocmd("FileType", {
  group = augroup,
  pattern = "go",
  callback = function()
    vim.opt_local.expandtab = false  -- Use real tabs (Go standard)
    vim.opt_local.shiftwidth = 4
    vim.opt_local.tabstop = 4
    vim.opt_local.softtabstop = 4
  end,
})

-- Lua, Javascript, Typescript: 2 spaces
autocmd("FileType", {
  group = augroup,
  pattern = { "lua", "javascript", "typescript", "javascriptreact", "typescriptreact", "json" },
  callback = function()
    vim.opt_local.expandtab = true
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
  end,
})

autocmd("FileType", {
  group = augroup,
  pattern = { "c", "cpp", "objc", "objcpp" },
  callback = function()
    vim.opt_local.expandtab = true
    vim.opt_local.shiftwidth = 4
    vim.opt_local.tabstop = 4
    vim.opt_local.softtabstop = 4
  end,
})

autocmd("BufWritePre", {
  pattern = { "*.c", "*.cpp", "*.h", "*.hpp" },
  callback = function()
    vim.lsp.buf.format()
  end,
})

-- Create an autocommand that runs whenever a colorscheme is loaded
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    vim.api.nvim_set_hl(0, "String", { fg = "#61bd6b" })
    -- Define the base Identifier color
    vim.api.nvim_set_hl(0, "Identifier", { fg = "#d3e3d3" })
    -- Link the others to it
    vim.api.nvim_set_hl(0, "@variable", { link = "Identifier" })
    vim.api.nvim_set_hl(0, "@lsp.type.variable.c", { link = "Identifier" })
    vim.api.nvim_set_hl(0, "@lsp.typemod.parameter.declaration.c", { link = "Identifier" })
  end,
})

-- Now load the theme
vim.cmd("colorscheme gruvbox-material")
