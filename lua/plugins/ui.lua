-- File: lua/plugins/ui.lua
-- All plugins related to User Interface

return {

  -- Icons
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
    config = function()
      require("nvim-web-devicons").setup()
    end,
  },

  -- Buffer Tab Line
  {
    "akinsho/bufferline.nvim",
    version = "*",
    event = { "BufReadPost", "BufNewFile" },
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
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "auto",
          section_separators = " | ",
          component_separators = " | ",
        },
      })
    end,
  },
}
