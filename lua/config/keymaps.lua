-- Keymaps configuration file

-- keymaps
vim.keymap.set({ "i", "n" }, "<C-s>", "<cmd>w<CR>", { noremap = true, silent = true, desc = "Save file" })

vim.keymap.set("n", "<C-a>", "gg0vG$", { noremap = true, silent = true, desc = "Select all" })
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete without yanking" })

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

-- Use ctrl + hjkl to move between splits
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Move to left split' })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Move to bottom split' })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Move to top split' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Move to right split' })

-- Same navigation from terminal mode so Ctrl+hjkl escapes the terminal split
vim.keymap.set('t', '<C-h>', [[<C-\><C-n><C-w>h]], { desc = 'Move to left split' })
vim.keymap.set('t', '<C-j>', [[<C-\><C-n><C-w>j]], { desc = 'Move to bottom split' })
vim.keymap.set('t', '<C-k>', [[<C-\><C-n><C-w>k]], { desc = 'Move to top split' })
vim.keymap.set('t', '<C-l>', [[<C-\><C-n><C-w>l]], { desc = 'Move to right split' })

-- Copy file paths
vim.keymap.set("n", "<leader>ca", ':let @+ = expand("%:p")<CR>', { desc = "Copy absolute file path" })
vim.keymap.set("n", "<leader>cr", ':let @+ = expand("%:.")<CR>', { desc = "Copy relative file path" })
vim.keymap.set("n", "<leader>cf", ':let @+ = expand("%:t")<CR>', { desc = "Copy file name" })
