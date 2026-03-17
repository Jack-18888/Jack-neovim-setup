
return {
  {
    "Mofiqul/vscode.nvim",
    lazy = true,
    priority = 900,
    opts = {},
    config = function()
      vim.cmd.colorscheme("vscode")
    end,
  }
}
