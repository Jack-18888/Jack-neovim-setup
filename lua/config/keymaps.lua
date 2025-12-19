-- Keymaps configuration file

-- keymaps
vim.keymap.set({ "i", "n" }, "<C-s>", "<cmd>w<CR>", { noremap = true, silent = true, desc = "Save file" })
vim.keymap.set({ "i", "n" }, "<C-p>", "<cmd>80vsp | term powershell<CR>", { noremap = true, silent = true, desc = "Open terminal in split" })

vim.keymap.set("n", "<C-a>", "gg0vG$", { noremap = true, silent = true, desc = "Select all" })
vim.keymap.set("n", "<leader>q", ":bd<CR>", { noremap = true, silent = true, desc = "Close buffer and split" })
vim.keymap.set("n", "<leader>fq", ":bd!<CR>", { noremap = true, silent = true, desc = "Force close buffer and split" })
vim.keymap.set("n", "<leader>t", ":NvimTreeToggle<CR>", { noremap = true, silent = true, desc = "Toggle file tree" })
vim.keymap.set("n", "<Tab>", ":BufferLineCycleNext<CR>", { noremap = true, silent = true, desc = "Next buffer" })
vim.keymap.set("n", "<S-Tab>", ":BufferLineCyclePrev<CR>", { noremap = true, silent = true, desc = "Previous buffer" })

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete without yanking" })

vim.keymap.set("n", "<leader><Tab>", function()
    vim.cmd("BufferLineCyclePrev")
    vim.cmd("BufferLineCloseRight")
end, { noremap = true, silent = true, desc = "Go to previous buffer and close those to the right" })

vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { noremap = true, silent = true, desc = "Exit terminal mode to Normal mode" })
 
-- telescope shortcuts 
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

-- toggle colorschemes 
colorschemes = { "tokyonight", "vscode", "gruvbox-material" }
local current_colorscheme_index = 1
vim.keymap.set('n', '<a-c>', function()
  current_colorscheme_index = current_colorscheme_index % #colorschemes + 1
  vim.cmd("colorscheme " .. colorschemes[current_colorscheme_index])
  require("lualine").setup({
    options = {
      theme = colorschemes[current_colorscheme_index],
      section_separators = " | ",
      component_separators = " | ",
    },
  })
  -- vim.api.nvim_set_hl(0, "Variable", { fg = "#abc7de" })
  -- vim.api.nvim_set_hl(0, "Constant", { fg = "#83afd4" })
  -- vim.api.nvim_set_hl(0, "@lsp.type.variable.cpp", { link = "Variable" })
  -- vim.api.nvim_set_hl(0, "@lsp.type.parameter.cpp", { link = "Variable" })
  -- vim.api.nvim_set_hl(0, "@lsp.mod.readonly.cpp", { link = "Constant" })
end, { desc = 'Toggle colorscheme' })
