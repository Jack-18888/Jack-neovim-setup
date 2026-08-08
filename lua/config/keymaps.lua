-- Keymaps configuration file

-- keymaps
vim.keymap.set({ "i", "n" }, "<C-s>", "<cmd>w<CR>", { noremap = true, silent = true, desc = "Save file" })
vim.keymap.set({ "i", "n" }, "<C-p>", "<cmd>80vsp | term pwsh<CR>", { noremap = true, silent = true, desc = "Open terminal in split" })

vim.keymap.set("n", "<C-a>", "gg0vG$", { noremap = true, silent = true, desc = "Select all" })
vim.keymap.set("n", "<leader>q", function()
  safe_close_buffer(false)
end, { noremap = true, silent = true, desc = "Close buffer and split" })
vim.keymap.set("n", "<leader>fq", function()
  safe_close_buffer(true)
end, { noremap = true, silent = true, desc = "Force close buffer and split" })

vim.keymap.set("n", "<leader>t", ":NvimTreeToggle<CR>", { noremap = true, silent = true, desc = "Toggle file tree" })
vim.keymap.set("n", "<leader>rv", ":NvimTreeFindFile<CR>", { noremap = true, silent = true, desc = "NvimTree reveal file" })
vim.keymap.set("n", "<Tab>", ":BufferLineCycleNext<CR>", { noremap = true, silent = true, desc = "Next buffer" })
vim.keymap.set("n", "<S-Tab>", ":BufferLineCyclePrev<CR>", { noremap = true, silent = true, desc = "Previous buffer" })

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete without yanking" })

vim.keymap.set("n", "<leader><Tab>", function()
    vim.cmd("BufferLineCyclePrev")
    vim.cmd("BufferLineCloseRight")
end, { noremap = true, silent = true, desc = "Go to previous buffer and close those to the right" })

vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { noremap = true, silent = true, desc = "Exit terminal mode to Normal mode" })

-- toggle colorschemes 
local colorschemes = { "catppuccin-frappe", "tokyonight", "vscode", "gruvbox-material" }
local current_colorscheme_index = 1
vim.keymap.set('n', '<a-c>', function()
  current_colorscheme_index = current_colorscheme_index % #colorschemes + 1
  local scheme = colorschemes[current_colorscheme_index]
  if scheme:find("tokyonight") then
    require("lazy").load({ plugins = { "tokyonight.nvim" } })
  elseif scheme:find("vscode") then
    require("lazy").load({ plugins = { "vscode.nvim" } })
  elseif scheme:find("gruvbox") then
    require("lazy").load({ plugins = { "gruvbox-material" } })
  end
  vim.cmd("colorscheme " .. scheme)
end, { desc = 'Toggle colorscheme' })


-- use cmdline for command 
-- vim.api.nvim_set_keymap('n', ':', '<cmd>FineCmdline<CR>', {noremap = true})

