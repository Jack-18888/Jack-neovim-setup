return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "main", -- Use the canary branch for the latest features
    dependencies = {
      { "nvim-lua/plenary.nvim" },     -- Required utility library
      { "nvim-telescope/telescope.nvim", optional = true }, -- Recommended for prompt selection
      -- IMPORTANT: Your Copilot provider (either of these)
      { "zbirenbaum/copilot.lua" },
    },
    -- build = "make tiktoken", -- Required for token calculations
    opts = {
      -- You can configure the chat window layout here
      window = {
        layout = 'vertical', -- Use a floating window for the chat
        position = 'right',
        width = 0.3,
      },
    },
    -- Define keybindings for easy access
    keys = {
      { "<leader>cc", "<cmd>CopilotChat<CR>", desc = "CopilotChat: Open Chat" },
      { "<leader>cce", "<cmd>CopilotChatExplain<CR>", desc = "CopilotChat: Explain Code" },
      { "<leader>cct", "<cmd>CopilotChatTests<CR>", desc = "CopilotChat: Generate Tests" },
    },
  },

  {
    "zbirenbaum/copilot.lua",
  	cmd = "Copilot",
  	event = "VimEnter",
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
  				python = true,
  				lua = true,
  				javascript = true,
          typescript = true,
          javascriptreact = true,
          typescriptreact = true,
          json = true,
  				bash = true,
          go = true,
  			},
  			-- More configuration options are available
  		})
  	end,
  }
}

