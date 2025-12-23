
return {
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
  }
}
