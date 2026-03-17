
return {
  "sindrets/diffview.nvim",
  dependencies = {
    -- Required dependency for enhanced icons in diffview
    "nvim-tree/nvim-web-devicons",
    -- Optional: Plenary is often a required utility for many plugins
    "nvim-lua/plenary.nvim",
  },
  keys = {
    -- Example keymap to toggle Diffview
    { "dv", function() vim.cmd("DiffviewOpen") end, desc = "Open Diffview" },
    { "dvb", function() vim.cmd("DiffviewClose") end, desc = "Close Diffview" },
  },
  -- Optional: Add configuration options here
  opts = {
    -- your options here
  },
}
