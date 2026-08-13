-- Buffer delete helpers (uses Snacks.bufdelete)

local function bufdelete(force)
  local current_buf = vim.api.nvim_get_current_buf()
  local ft = vim.bo[current_buf].filetype
  -- Don't close explorer or its layout buffers
  if ft == "snacks_picker_explorer" or ft == "snacks_layout_box" then
    return
  end
  Snacks.bufdelete({ buf = current_buf, force = force })
end

vim.api.nvim_create_user_command("Bd", function(opts)
  bufdelete(opts.bang)
end, { bang = true })

vim.cmd([[cnoreabbrev bd Bd]])
vim.cmd([[cnoreabbrev bd! Bd!]])

vim.keymap.set("n", "<leader>q", function()
  bufdelete(false)
end, { noremap = true, silent = true, desc = "Close buffer and split" })
vim.keymap.set("n", "<leader>fq", function()
  bufdelete(true)
end, { noremap = true, silent = true, desc = "Force close buffer and split" })

return {}
