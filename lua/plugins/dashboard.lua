return {
  {
    'goolord/alpha-nvim',
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
        [[     /$$   /$$             /$$  /$$                        /$$   /$$                                    /$$                 /$$    ]],
        [[    | $$  | $$            | $$ | $$                       | $$$ | $$                                   |__/                | $$    ]],
        [[    | $$  | $$   /$$$$$$  | $$ | $$   /$$$$$$             | $$$$| $$   /$$$$$$    /$$$$$$   /$$    /$$  /$$  /$$$$$$/$$$$  | $$    ]],
        [[    | $$$$$$$$  /$$__  $$ | $$ | $$  /$$__  $$            | $$ $$ $$  /$$__  $$  /$$__  $$ |  $$  /$$/ | $$ | $$_  $$_  $$ | $$    ]],
        [[    | $$__  $$ | $$$$$$$$ | $$ | $$ | $$  \ $$            | $$  $$$$ | $$$$$$$$ | $$  \ $$  \  $$/$$/  | $$ | $$ \ $$ \ $$ |__/    ]],
        [[    | $$  | $$ | $$_____/ | $$ | $$ | $$  | $$            | $$\  $$$ | $$_____/ | $$  | $$   \  $$$/   | $$ | $$ | $$ | $$         ]],
        [[    | $$  | $$ |  $$$$$$$ | $$ | $$ |  $$$$$$/  /$$       | $$ \  $$ |  $$$$$$$ |  $$$$$$/    \  $/    | $$ | $$ | $$ | $$  /$$    ]],
        [[    |__/  |__/  \_______/ |__/ |__/  \______/  | $/       |__/  \__/  \_______/  \______/      \_/     |__/ |__/ |__/ |__/ |__/    ]],
        [[                                               |_/                                                                                 ]],
        [[                                                                                                                                   ]],
        [[                                                                                                                                   ]],
        [[                                                                                                                                   ]],
        [[                                                                                                                                   ]],
        [[                                                                                                                                   ]],
        }

        -- Change the Buttons (Menu)
        dashboard.section.buttons.val = {
            dashboard.button("e", "  New File", ":ene <BAR> startinsert <CR>"),
            dashboard.button("Space t", "  File Tree", ":NvimTreeToggle<CR>"),
            dashboard.button("Ctrl p", "  Open Terminal", ":80vsp | term powershell<CR>"),
            dashboard.button("s", "勒  Search Text", ":Telescope live_grep<CR>"), 
            dashboard.button("f", "  Find File", ":Telescope find_files<CR>"), 
            dashboard.button("r", "  Recent", ":Telescope oldfiles<CR>"),
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
