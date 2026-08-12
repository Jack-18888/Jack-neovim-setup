return {
  {
    "folke/snacks.nvim",
    lazy = false, -- snacks.nvim recommends loading eagerly
    priority = 900,
    ---@type snacks.Config
    opts = {
      bufdelete = { enabled = true },
    },
  },
}
