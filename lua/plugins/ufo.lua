return {

  -- fold and unfold code blocks 
  {
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async" },
    event = "BufReadPost",
    init = function()
      -- INFO: Req #1: Disable auto-folding
      -- We set the fold level high so everything starts out open.
      vim.opt.foldlevel = 99
      vim.opt.foldlevelstart = 99
      vim.opt.foldenable = true

      -- INFO: Req #2: Add a button column
      -- '1' shows a 1-character wide column with indicators (+/-)
      -- You can click these to toggle folds.
      vim.opt.foldcolumn = "1"
      vim.opt.fillchars = {
        fold = " ", 
        foldopen = "▼",
        foldclose = "▶",
        foldsep = " ",
        eob = " ",
      }

      -- INFO: Req #4: Open folds on search
      -- "all" ensures that commands like search (/), motions, etc.,
      -- automatically open the folds they traverse.
      vim.opt.foldopen = "jump,mark,percent,quickfix,search,tag,undo"
    end,
    config = function()
      local ufo = require("ufo")

      ufo.setup({
        provider_selector = function(bufnr, filetype, buftype)
          return { "treesitter", "indent" }
        end,
        open_fold_hl_timeout = 150,
      })

      -- Keymaps
      vim.keymap.set("n", "zR", ufo.openAllFolds, { desc = "Open all folds" })
      vim.keymap.set("n", "zM", ufo.closeAllFolds, { desc = "Close all folds" })
    end,
  },

  -- 1. statuscol.nvim: Takes control of the column to hide the numbers
  {
    "luukvbaal/statuscol.nvim",
    config = function()
      local builtin = require("statuscol.builtin")
      require("statuscol").setup({
        setopt = true,
        segments = {
          -- This segment will show the fold icon, but NOT the nested number
          { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
          { text = { " " } }, -- Space
          { text = { builtin.lnumfunc }, click = "v:lua.ScLa" }, -- Line number
          { text = { " " } }, -- Space
        },
      })
    end,
  },
}
