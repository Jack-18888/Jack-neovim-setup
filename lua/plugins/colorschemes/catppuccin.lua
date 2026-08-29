
return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    opts = {
      compile_path = vim.fn.stdpath("cache") .. "/catppuccin",
      compile = true,
      -- Disable auto-detection to prevent slow vim.pack filesystem scanning at startup
      auto_integrations = false,
      integrations = {
        alpha = true,
        cmp = true,
        dap = true,
        dap_ui = true,
        diffview = true,
        fidget = true,
        flash = true,
        gitsigns = true,
        mason = true,
        neogit = true,
        notify = true,
        snacks = true,
        telescope = true,
        treesitter = true,
        ufo = true,
        which_key = true,
      },
    },
  },
}
