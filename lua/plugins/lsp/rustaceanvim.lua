
return {
  {
    'mrcjkb/rustaceanvim',
    version = '^6', -- Recommended
    lazy = false, -- This plugin is already lazy
    config = function()
      -- This is where you configure rustaceanvim
      vim.g.rustaceanvim = {
        server = {
          on_attach = function(client, bufnr)
            -- You can put your keymaps here
            vim.keymap.set("n", "<leader>a", function()
              vim.cmd.RustLsp('codeAction')
            end, { silent = true, buffer = bufnr, desc = "Rust Code Action" })

            vim.keymap.set("n", "K", function()
              vim.cmd.RustLsp({'hover', 'actions'})
            end, { silent = true, buffer = bufnr }) 
          end,
          default_settings = {
            ['rust-analyzer'] = {
              checkOnSave = {
                command = "check",
              },
            },
          },
        },
      }
    end,
  }
}
