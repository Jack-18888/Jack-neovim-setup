
return {
  {
    "folke/tokyonight.nvim",
    lazy = true,
    priority = 900,
    opts = {
      on_highlights = function(hl, colors)
        hl["@variable"] = {
            fg = "#abc7de", 
        }

        hl.Identifier = {
            fg = "#abc7de",
        }
      end,
    },
    config = function(_, opts)
      require("tokyonight").setup(opts)
      vim.cmd.colorscheme("tokyonight")
    end,
  }
}
