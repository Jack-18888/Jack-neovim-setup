return {

  -- Colorscheme
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
  },

  {
    "sainnhe/gruvbox-material",
    lazy = true,
    priority = 900,
    opts = {},
    config = function()
      vim.cmd.colorscheme("gruvbox-material")

      vim.api.nvim_set_hl(0, "@variable", { fg = "#abc7de" })
      vim.api.nvim_set_hl(0, "Identifier", { fg = "#abc7de" })
    end,
  },

  {
    "Mofiqul/vscode.nvim",
    lazy = true,
    priority = 900,
    opts = {},
    config = function()
      vim.cmd.colorscheme("vscode")
    end,
  },

}

