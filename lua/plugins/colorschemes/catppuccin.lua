
return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    opts = {
      compile_path = vim.fn.stdpath("cache") .. "/catppuccin",
      compile = true,
      -- Disable all default integrations, enable only what we use
      default_integrations = false,
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
        nvimtree = true,
        telescope = true,
        treesitter = true,
        ufo = true,
        which_key = true,
      },
    },
  },
}
