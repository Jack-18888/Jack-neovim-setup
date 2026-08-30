
return {
  -- Buffer Tab Line
  {
    "akinsho/bufferline.nvim",
    version = "*",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<Tab>", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
      { "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", desc = "Previous buffer" },
      {
        "<leader><Tab>",
        function()
          vim.cmd("BufferLineCyclePrev")
          vim.cmd("BufferLineCloseRight")
        end,
        desc = "Go to previous buffer and close those to the right",
      },
    },
    config = function()
      require("bufferline").setup({
        options = {
          show_buffer_icons = true,
          show_buffer_close_icons = true,
          show_close_icon = true,
          offsets = {
            {
              filetype = "snacks_layout_box",
              text = "File Explorer",
              text_align = "left",
              separator = true,
            },
          },
          separator_style = "thin",
        },
      })
    end,
  }
}
