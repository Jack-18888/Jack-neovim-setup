return {
  {
    "folke/snacks.nvim",
    lazy = false, -- snacks.nvim recommends loading eagerly
    priority = 900,
    ---@type snacks.Config
    opts = {
      bufdelete = { enabled = true },
      explorer = { enabled = true, replace_netrw = true },
      scroll = { 
        enabled = true,
        animate = { 
          duration = { step = 5, total = 80 }, -- Default is step=10, total=200
          easing = "linear",
        },
        -- Speeds up sequential scrolling (holding down keys)
        animate_repeat = {
          delay = 100, 
          duration = { step = 3, total = 30 }, -- Default is step=5, total=50
          easing = "linear",
        },
      },
      terminal = {
        enabled = true,
        shell = "pwsh",
        win = {
          style = "terminal",
          position = "bottom",
          height = 0.32,
        },
      },
      picker = {
        sources = {
          explorer = {
            focus = "list",
            layout = {
              -- auto_hide = { "input" },
              layout = {
                position = "left",
                width = 35,
                box = "vertical",
                { win = "list" },
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
