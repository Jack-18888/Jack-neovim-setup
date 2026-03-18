return {
  "olimorris/codecompanion.nvim",
  keys= {
    { "<leader>ai", "<cmd>CodeCompanion<CR>", mode = "v", desc = "Prompt AI Inline" },
    { "<leader>aa", "<cmd>CodeCompanionActions<CR>", mode = { "n", "v" }, desc = "AI Action Palette" },
    { "<leader>ac", "<cmd>CodeCompanionChat Toggle<CR>", mode = { "n", "v" }, desc = "Toggle AI Chat" },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    require("codecompanion").setup({
      -- Set GitHub Copilot as the default AI for both chat and inline prompts
      strategies = {
        chat = { adapter = "copilot" },
        inline = { adapter = "copilot" },
      },
      -- Configure how the diffs are displayed
      display = {
        diff = {
          provider = "default", -- Uses Neovim's native diff. You can change this to "mini_diff" if you use that plugin.
        },
      },
    })
  end,
}
