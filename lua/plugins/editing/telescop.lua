-- plugins/telescope.lua:
return {
  'nvim-telescope/telescope.nvim', tag = 'v0.1.9',
  keys = {
    vim.keymap.set('n', '<leader>ff', require("telescope.builtin").find_files, { desc = 'Telescope find files' }),
    vim.keymap.set('n', '<leader>fg', require("telescope.builtin").live_grep, { desc = 'Telescope live grep' }),
    vim.keymap.set('n', '<leader>fb', require("telescope.builtin").buffers, { desc = 'Telescope buffers' }),
    vim.keymap.set('n', '<leader>fh', require("telescope.builtin").help_tags, { desc = 'Telescope help tags' }),
  },
  dependencies = { 'nvim-lua/plenary.nvim' },
}
