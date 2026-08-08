
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


return {
  -- File Explorer
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = "NvimTreeToggle",
    config = function()
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
      require("nvim-tree").setup({
        sync_root_with_cwd = true,
        view = { width = 35 },
        git = { enable = true },
        renderer = {
          group_empty = true,
          icons = {
            show = {
              file = true,
              folder = true,
              folder_arrow = true,
              git = true,
            },
          },
        },
        actions = {
          open_file = {
            quit_on_open = false,
          },
        },
        filters = {
          dotfiles = false, -- Set to true to HIDE dotfiles by default
          git_ignored = false, -- Set to true to HIDE git-ignored files by default
        },
      })
   end,
  }
}
