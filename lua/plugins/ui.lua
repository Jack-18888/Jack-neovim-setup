-- File: lua/plugins/ui.lua
-- All plugins related to User Interface

return {

  -- Colorscheme
  {
    "folke/tokyonight.nvim",
    lazy = true,
    priority = 900,
    opts = {},
    config = function()
      vim.cmd.colorscheme("tokyonight")
    end,
  },

  {
    "sainnhe/gruvbox-material",
    lazy = true,
    priority = 900,
    opts = {},
    config = function()
      vim.cmd.colorscheme("gruvbox-material")
    end,
  },

  -- File Explorer
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
      require("nvim-tree").setup({
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
      })
   end,
  },

  -- Icons
  {
    "nvim-tree/nvim-web-devicons",
    config = function()
      require("nvim-web-devicons").setup()
    end,
  },

  -- Buffer Tab Line
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("bufferline").setup({
        options = {
          show_buffer_icons = true,
          show_buffer_close_icons = true,
          show_close_icon = true,
          offsets = {
            {
              filetype = "NvimTree",
              text = "File Explorer",
              text_align = "left",
              separator = true,
            },
          },
          separator_style = "thin",
        },
      })
    end,
  },

  -- Status Line
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "gruvbox-material",
          section_separators = " | ",
          component_separators = " | ",
        },
      })
    end,
  },
}
