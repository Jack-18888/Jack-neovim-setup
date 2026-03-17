-- plugins/telescope.lua:
return {
  'nvim-telescope/telescope.nvim', tag = 'v0.1.9',
  keys = {
    vim.keymap.set('n', '<leader>ff', "<cmd>Telescope find_files<cr>", { desc = 'Telescope find files' }),
    vim.keymap.set('n', '<leader>fg', "<cmd>Telescope live_grep<cr>", { desc = 'Telescope live grep' }),
    vim.keymap.set('n', '<leader>fb', "<cmd>Telescope buffers<cr>", { desc = 'Telescope buffers' }),
    vim.keymap.set('n', '<leader>fh', "<cmd>Telescope help_tags<cr>", { desc = 'Telescope help tags' }),
  },
  dependencies = { 'nvim-lua/plenary.nvim' },
}
