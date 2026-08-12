return {
  {
    'goolord/alpha-nvim',
    event = "VimEnter",
    cond = function()
      return vim.fn.argc() == 0
    end,
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function ()
        local alpha = require('alpha')
        local dashboard = require('alpha.themes.dashboard')

        -- Change the Header (The big ASCII Art)
        dashboard.section.header.val = {
        [[                                                                                                                                   ]],
        [[                                                                                                                                   ]],
        [[                                                                                                                                   ]],
        [[                                                                                                                                   ]],
        [[                                                                                                                                   ]],
        [[                                                                                                                                   ]],
        [[                                                                                                                                   ]],
        [[                                                                                                                                   ]],
        [[                                                                                                                                   ]],
        [[                     /$$   /$$           /$$ /$$                       /$$$$$                     /$$       /$$                    ]],
        [[                    | $$  | $$          | $$| $$                      |__  $$                    | $$      | $$                    ]],
        [[                    | $$  | $$  /$$$$$$ | $$| $$  /$$$$$$                | $$  /$$$$$$   /$$$$$$$| $$   /$$| $$                    ]],
        [[                    | $$$$$$$$ /$$__  $$| $$| $$ /$$__  $$               | $$ |____  $$ /$$_____/| $$  /$$/| $$                    ]],
        [[                    | $$__  $$| $$$$$$$$| $$| $$| $$  \ $$          /$$  | $$  /$$$$$$$| $$      | $$$$$$/ |__/                    ]],
        [[                    | $$  | $$| $$_____/| $$| $$| $$  | $$         | $$  | $$ /$$__  $$| $$      | $$_  $$                         ]],
        [[                    | $$  | $$|  $$$$$$$| $$| $$|  $$$$$$//$$      |  $$$$$$/|  $$$$$$$|  $$$$$$$| $$ \  $$ /$$                    ]],
        [[                    |__/  |__/ \_______/|__/|__/ \______/| $/       \______/  \_______/ \_______/|__/  \__/|__/                    ]],
        [[                                                                                                                                   ]],
        [[                                                                                                                                   ]],
        [[                                                                                                                                   ]],
        [[                                                                                                                                   ]],
        [[                                                                                                                                   ]],
        [[                                                                                                                                   ]],
        [[                                                                                                                                   ]],
        [[                                                                                                                                   ]],
        [[                                                                                                                                   ]],
        [[                                                                                                                                   ]],
        }

        -- Change the Buttons (Menu)
        dashboard.section.buttons.val = {
            dashboard.button("e", "  New File", ":ene <BAR> startinsert <CR>"),
            dashboard.button("Space t", "  File Tree", ":lua Snacks.explorer.open()<CR>"),
            dashboard.button("Ctrl p", "  Open Terminal", ":80vsp | term powershell<CR>"),
            dashboard.button("Space f g", "勒 Search Text", ":Telescope live_grep<CR>"), 
            dashboard.button("Space f f", "  Find File", ":Telescope find_files<CR>"), 
            dashboard.button("q", "  Quit", ":qa<CR>"),
        }

        -- Change the Footer
        dashboard.section.footer.val = "Time to code."

        -- Define the layout order
        dashboard.config.layout = {
            dashboard.section.header,
            { type = "padding", val = 2 }, -- 2 lines of space between Header and Buttons
            dashboard.section.buttons,
            { type = "padding", val = 5 }, -- 5 lines of space between Buttons and Footer (CHANGE THIS NUMBER)
            dashboard.section.footer,
        }

        -- Activate the dashboard
        alpha.setup(dashboard.config)
    end
  },
}
