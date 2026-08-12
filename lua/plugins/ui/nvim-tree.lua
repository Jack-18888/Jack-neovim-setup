
local function bufdelete(force)
  local current_buf = vim.api.nvim_get_current_buf()
  if vim.bo[current_buf].filetype == "NvimTree" then
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




return {
  -- File Explorer
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<leader>t", "<cmd>NvimTreeToggle<CR>", mode = "n", desc = "Toggle file tree" },
      { "<leader>rv", "<cmd>NvimTreeFindFile<CR>", mode = "n", desc = "NvimTree reveal file" },
    },
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
