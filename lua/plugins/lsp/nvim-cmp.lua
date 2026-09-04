
return {
  -- Autocompletion
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "abecodes/tabout.nvim",
    },
    config = function()
      local cmp = require("cmp")
      local types = require("cmp.types")

      cmp.setup({
        snippet = {
          expand = function(args)
            vim.snippet.expand(args.body)
          end,
        },
        sources = cmp.config.sources({
          {
            name = "nvim_lsp",
            entry_filter = function(entry, _)
              local item = entry:get_completion_item()
              if entry:get_kind() == types.lsp.CompletionItemKind.Snippet then
                return false
              end
              if item and item.insertTextFormat == types.lsp.InsertTextFormat.Snippet then
                return false
              end
              return true
            end,
          },
          { name = "lazydev", group_index = 0 },
          { name = "buffer", keyword_length = 3 },
          { name = "path" },
        }),
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
      })
    end,
  }
}
