

return {
  {
    "zbirenbaum/copilot.lua",
  	cmd = "Copilot",
  	event = "InsertEnter",
  	config = function()
  		require("copilot").setup({
  			suggestion = {
  				enabled = true,
  				auto_trigger = true,
  				debounce = 500,
  				keymap = {
  					accept = "<C-f>",
  					accept_word = "<C-w>",
  					accept_line = "<C-l>",
  					reject = "<C-r>",
  					prev = "<C-p>",
  					next = "<C-n>",
  				},
  			},
  			panel = {
  				enabled = true,
  				auto_refresh = true,
  			},
  			-- You can customize the copilot setup further here
  			-- For example, you can change the filetypes where Copilot is enabled
  			filetypes = {
          ["*"] = true,
          sh = function ()
            if string.match(vim.fs.basename(vim.api.nvim_buf_get_name(0)), '^%.env.*') then
              -- disable for .env files
              return false
            end
            return true
          end,
  			},
  			-- More configuration options are available
  		})
  	end,
  }
}

