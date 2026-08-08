
return {
  {
    "romus204/tree-sitter-manager.nvim",
    cmd = { "TSManager" },
    dependencies = {}, -- tree-sitter CLI must be installed system-wide
    config = function()
      require("tree-sitter-manager").setup({})
    end,
  }
}
