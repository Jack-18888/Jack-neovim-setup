
-- handles multiple-line commenting and uncommenting


return {
  "numToStr/Comment.nvim",
  opts = {},
  keys = {
    { "<C-_>", mode = { "n", "v" } }, -- Ensure lazy loads on this key
    { "gcc", mode = "n" },            -- Ensure lazy loads on standard command
    { "gc", mode = "v" },
  },
  config = function(_, opts)
    local comment = require("Comment")
    comment.setup(opts)

    local api = require("Comment.api")

    vim.keymap.set("n", "<C-_>", function()
      api.toggle.linewise.current()
    end, { desc = "Toggle comment on current line" })

    vim.keymap.set("v", "<C-_>", "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", { desc = "Toggle comment on selection" })
  end,
}
