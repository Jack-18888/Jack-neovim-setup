return {
  {
    "folke/snacks.nvim",
    lazy = false, -- snacks.nvim recommends loading eagerly
    priority = 900,
    ---@type snacks.Config
    opts = {
      bufdelete = { enabled = true },
      explorer = { enabled = true, replace_netrw = true },
      picker = {
        sources = {
          explorer = {
            layout = {
              layout = {
                position = "left",
                width = 35,
              },
            },
            win = {
              list = {
                keys = {
                  ["<leader>rv"] = "explorer_focus",
                },
              },
            },
          },
        },
      },
    },
    keys = {
      { "<leader>t", function() Snacks.explorer.open() end, mode = "n", desc = "Toggle file tree" },
      { "<leader>rv", function() Snacks.explorer.reveal() end, mode = "n", desc = "Reveal file in explorer" },
    },
  },
}
