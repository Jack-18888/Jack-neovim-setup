-- Create a group to prevent duplication
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup("CustomIndent", { clear = true })

-- 1. Python: 4 spaces
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

-- 2. Golang: Tabs (Viewed as 4 spaces)
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

-- 3. Lua, Javascript, Typescript: 2 spaces
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
