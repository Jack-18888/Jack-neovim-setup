-- Keymaps configuration file

-- keymaps
vim.keymap.set({ "i", "n" }, "<C-s>", "<cmd>w<CR>", { noremap = true, silent = true, desc = "Save file" })
vim.keymap.set({ "i", "n" }, "<C-p>", "<cmd>80vsp | term pwsh<CR>", { noremap = true, silent = true, desc = "Open terminal in split" })
vim.keymap.set('n', '<leader>rv', function()
  local api = require('nvim-tree.api')
  api.tree.find_file({ open = true, focus = true })
end, { silent = true, desc = 'NvimTree Reveal File' })

local function safe_close_buffer(force)
  local current_buf = vim.api.nvim_get_current_buf()
  local current_win = vim.api.nvim_get_current_win()

  if vim.bo[current_buf].filetype == "NvimTree" then
    return
  end

  local listed_buffers = {}
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_valid(bufnr) and vim.bo[bufnr].buflisted and vim.bo[bufnr].filetype ~= "NvimTree" then
      table.insert(listed_buffers, bufnr)
    end
  end

  local target_buf
  if #listed_buffers <= 1 then
    vim.cmd("enew")
  else
    for index, bufnr in ipairs(listed_buffers) do
      if bufnr == current_buf then
        target_buf = listed_buffers[index - 1] or listed_buffers[index + 1]
        break
      end
    end

    if target_buf and target_buf ~= current_buf then
      vim.api.nvim_win_set_buf(current_win, target_buf)
    end
  end

  if vim.api.nvim_buf_is_valid(current_buf) then
    vim.api.nvim_buf_delete(current_buf, { force = force })
  end
end

vim.api.nvim_create_user_command("Bd", function(opts)
  safe_close_buffer(opts.bang)
end, { bang = true })

vim.cmd([[cnoreabbrev bd Bd]])
vim.cmd([[cnoreabbrev bd! Bd!]])

vim.keymap.set("n", "<C-a>", "gg0vG$", { noremap = true, silent = true, desc = "Select all" })
vim.keymap.set("n", "<leader>q", function()
  safe_close_buffer(false)
end, { noremap = true, silent = true, desc = "Close buffer and split" })
vim.keymap.set("n", "<leader>fq", function()
  safe_close_buffer(true)
end, { noremap = true, silent = true, desc = "Force close buffer and split" })

vim.keymap.set("n", "<leader>t", ":NvimTreeToggle<CR>", { noremap = true, silent = true, desc = "Toggle file tree" })
vim.keymap.set("n", "<Tab>", ":BufferLineCycleNext<CR>", { noremap = true, silent = true, desc = "Next buffer" })
vim.keymap.set("n", "<S-Tab>", ":BufferLineCyclePrev<CR>", { noremap = true, silent = true, desc = "Previous buffer" })

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete without yanking" })

vim.keymap.set("n", "<leader><Tab>", function()
    vim.cmd("BufferLineCyclePrev")
    vim.cmd("BufferLineCloseRight")
end, { noremap = true, silent = true, desc = "Go to previous buffer and close those to the right" })

vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { noremap = true, silent = true, desc = "Exit terminal mode to Normal mode" })

-- toggle colorschemes 
colorschemes = { "catppuccin-frappe", "tokyonight", "vscode", "gruvbox-material" }
local current_colorscheme_index = 1
vim.keymap.set('n', '<a-c>', function()
  current_colorscheme_index = current_colorscheme_index % #colorschemes + 1
  vim.cmd("colorscheme " .. colorschemes[current_colorscheme_index])
  
  -- vim.api.nvim_set_hl(0, "Variable", { fg = "#abc7de" })
  -- vim.api.nvim_set_hl(0, "Constant", { fg = "#83afd4" })
  -- vim.api.nvim_set_hl(0, "@lsp.type.variable.cpp", { link = "Variable" })
  -- vim.api.nvim_set_hl(0, "@lsp.type.parameter.cpp", { link = "Variable" })
  -- vim.api.nvim_set_hl(0, "@lsp.mod.readonly.cpp", { link = "Constant" })
end, { desc = 'Toggle colorscheme' })


-- use cmdline for command 
-- vim.api.nvim_set_keymap('n', ':', '<cmd>FineCmdline<CR>', {noremap = true})

