return {
  -- Treesitter textobjects for functions and classes (Neovim 0.12+)
  -- Highlighting & indentation are now native — only textobjects need a plugin.
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    keys = {
      { "af", mode = { "x", "o" }, desc = "Select outer function" },
      { "if", mode = { "x", "o" }, desc = "Select inner function" },
      { "ac", mode = { "x", "o" }, desc = "Select outer class" },
      { "ic", mode = { "x", "o" }, desc = "Select inner class" },
      { "]f", mode = { "n", "x", "o" }, desc = "Next function start" },
      { "]c", mode = { "n", "x", "o" }, desc = "Next class start" },
      { "]g", mode = { "n", "x", "o" }, desc = "Next function end" },
      { "]v", mode = { "n", "x", "o" }, desc = "Next class end" },
      { "[f", mode = { "n", "x", "o" }, desc = "Prev function start" },
      { "[c", mode = { "n", "x", "o" }, desc = "Prev class start" },
      { "[g", mode = { "n", "x", "o" }, desc = "Prev function end" },
      { "[v", mode = { "n", "x", "o" }, desc = "Prev class end" },
    },
    init = function()
      -- Enable native treesitter highlighting for all filetypes with a parser
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("NativeTreesitter", { clear = true }),
        callback = function(args)
          pcall(vim.treesitter.start, args.buf)
        end,
      })
    end,
    config = function()

      -- Configure textobjects (options only — keymaps are set manually below)
      require("nvim-treesitter-textobjects").setup({
        select = {
          lookahead = true,
        },
        move = {
          set_jumps = true,
        },
      })

      local select = require("nvim-treesitter-textobjects.select")
      local move = require("nvim-treesitter-textobjects.move")

      -- Select textobjects (visual + operator-pending)
      vim.keymap.set({ "x", "o" }, "af", function() select.select_textobject("@function.outer") end, { desc = "Select outer function" })
      vim.keymap.set({ "x", "o" }, "if", function() select.select_textobject("@function.inner") end, { desc = "Select inner function" })
      vim.keymap.set({ "x", "o" }, "ac", function() select.select_textobject("@class.outer") end, { desc = "Select outer class" })
      vim.keymap.set({ "x", "o" }, "ic", function() select.select_textobject("@class.inner") end, { desc = "Select inner class" })

      -- Move: go to next/previous function/class
      vim.keymap.set({ "n", "x", "o" }, "]f", function() move.goto_next_start("@function.outer") end, { desc = "Next function start" })
      vim.keymap.set({ "n", "x", "o" }, "]c", function() move.goto_next_start("@class.outer") end, { desc = "Next class start" })
      vim.keymap.set({ "n", "x", "o" }, "]g", function() move.goto_next_end("@function.outer") end, { desc = "Next function end" })
      vim.keymap.set({ "n", "x", "o" }, "]v", function() move.goto_next_end("@class.outer") end, { desc = "Next class end" })
      vim.keymap.set({ "n", "x", "o" }, "[f", function() move.goto_previous_start("@function.outer") end, { desc = "Prev function start" })
      vim.keymap.set({ "n", "x", "o" }, "[c", function() move.goto_previous_start("@class.outer") end, { desc = "Prev class start" })
      vim.keymap.set({ "n", "x", "o" }, "[g", function() move.goto_previous_end("@function.outer") end, { desc = "Prev function end" })
      vim.keymap.set({ "n", "x", "o" }, "[v", function() move.goto_previous_end("@class.outer") end, { desc = "Prev class end" })
    end,
  },
}
