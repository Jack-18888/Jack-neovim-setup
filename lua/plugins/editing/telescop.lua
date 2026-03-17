-- plugins/telescope.lua:
return {
  'nvim-telescope/telescope.nvim', tag = 'v0.1.9',
  keys = {
    { '<leader>ff', '<cmd>Telescope find_files<cr>', desc = 'Find Files' },
    { '<leader>fg', '<cmd>Telescope live_grep<cr>',  desc = 'Live Grep' },
    { '<leader>fb', '<cmd>Telescope buffers<cr>',    desc = 'Buffers' },
    { '<leader>fh', '<cmd>Telescope help_tags<cr>',  desc = 'Help Tags' },
  },
  dependencies = { 'nvim-lua/plenary.nvim' },
}
