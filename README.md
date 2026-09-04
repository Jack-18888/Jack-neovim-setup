# Jack's Neovim Setup

A fast, fully featured Neovim configuration for Windows 11, written in Lua and managed by [lazy.nvim](https://github.com/folke/lazy.nvim). It turns Neovim into a modern IDE with LSP support, autocompletion, Treesitter, debugging, git integration, fuzzy search, AI code suggestions, and a polished UI — all lazy-loaded for quick startup.

## Highlights

- **Fast startup** — `vim.loader.enable()` bytecode caching plus lazy.nvim, with every plugin lazy-loaded unless explicitly configured.
- **Language tooling** — LSP via nvim-lspconfig + Mason: Python (pyright + ruff), Go (gopls), C/C++ (clangd), Rust (rust-analyzer via rustaceanvim), TypeScript/JavaScript (typescript-tools). Autocompletion with nvim-cmp.
- **Treesitter** — syntax highlighting, indentation, and textobjects for functions and classes.
- **Formatting & linting** — conform formats on save (ruff_format for Python, goimports + gofumpt for Go); nvim-lint runs ruff for Python.
- **Debugging** — nvim-dap with nvim-dap-ui, automatic C/C++ compilation on `<F5>`, `F1`/`F2`/`F3` stepping controls, and ready cppdbg/gdb configuration.
- **Git workflow** — gitsigns gutter signs, Neogit UI, and Diffview.
- **Search** — Telescope with a persistent include/exclude glob policy and multi-select file opening.
- **UI polish** — nvim-tree file explorer, bufferline tabs, lualine statusline, alpha dashboard, noice.nvim, inline diagnostics, and ufo folding with statuscol.
- **Copilot** — copilot.lua included; suggestions are off by default and can be enabled in `lua/plugins/ai/copilot.lua`.
- **Themes** — Catppuccin (default), Tokyo Night, VSCode, and Gruvbox Material; cycle with `Alt-c`.

## Requirements

- Neovim 0.11+
- Git and ripgrep (used by Telescope)
- A Nerd Font (JetBrainsMono Nerd Font is configured)
- Windows 11 (this branch): clangd from MSYS2 UCRT64 (`C:\msys64\ucrt64\bin\clangd.exe`), gdb for C/C++ debugging, and Python 3.14 at `C:/Users/T14G3/AppData/Local/Python/pythoncore-3.14-64`
- Language tools installed through Mason (`:Mason`): pyright, ruff, gopls, gofumpt, goimports, clangd, clang-format

## Installation

Clone the repo into Neovim's config directory:

```powershell
git clone git@github.com:Jack-18888/Jack-neovim-setup.git $env:LOCALAPPDATA\nvim
```

lazy.nvim bootstraps itself on first launch. Install or update plugins with:

```
:Lazy sync
```

Install language tools via `:Mason`, then restart Neovim. The repo is organized into per-OS branches — `main`, `windows11-config`, and `ubuntu-config` — so check out the branch that matches your system.

## Project structure

```
init.lua               Entry point: loader, global options, colorscheme
lua/
  config/
    lazy.lua           lazy.nvim bootstrap, leader keys, plugin spec imports
    keymaps.lua        Global keymaps + :Bd buffer-close command
    autocmds.lua       Per-filetype indentation rules
  plugins/
    ai/                Copilot
    colorschemes/      Catppuccin, Tokyo Night, VSCode, Gruvbox Material
    debugging/         nvim-dap + nvim-dap-ui
    editing/           conform, nvim-lint, autopairs, comment, flash, telescope,
                       diffview, neogit, gitsigns, tabout, which-key, ufo/statuscol
    lsp/               lazydev, mason, nvim-cmp, nvim-lspconfig,
                       rustaceanvim, typescript-tools
    treesitter/        nvim-treesitter + textobjects
    ui/                nvim-tree, bufferline, lualine, alpha, noice,
                       fidget, tiny-inline-diagnostic
```

## Keymaps

Leader is `Space`.

| Key | Action |
| --- | --- |
| `<C-s>` | Save |
| `<C-p>` | Open PowerShell terminal in a vertical split |
| `<C-a>` | Select all |
| `<Tab>` / `<S-Tab>` | Next / previous buffer |
| `<leader>t` | Toggle file tree |
| `<leader>q` / `<leader>fq` | Close buffer / force-close buffer (split preserved) |
| `<leader>d` | Delete without yanking |
| `<A-c>` | Cycle colorscheme |
| `<leader>ff` / `<leader>fg` | Telescope: find files / live grep |
| `<leader>fb` / `<leader>fh` | Telescope: buffers / help tags |
| `<leader>fa` / `<leader>fx` / `<leader>fp` / `<leader>fr` | Telescope glob policy: include / exclude / show / reset |
| `<leader>f` | Format file (conform) |
| `<C-_>` | Toggle comment |
| `s` / `S` | Flash jump / Treesitter jump |
| `dv` / `dvb` | Diffview: open / close |
| `<leader>gg` | Open Neogit |
| `gd` / `K` / `gi` / `gr` | LSP: definition / hover / implementation / references |
| `<leader>rn` / `<leader>ca` / `<leader>e` | LSP: rename / code action / diagnostics |
| `<F5>` / `<F1>` / `<F2>` / `<F3>` | Debug: continue / step into / step over / step out |
| `<leader>b` / `<leader>B` | Debug: toggle / conditional breakpoint |
| `zR` / `zM` | Open / close all folds |
| `]f` `[f` `]c` `[c` | Jump to next/previous function / class |
| `af` `if` `ac` `ic` | Select function/class (outer/inner) |

Copilot bindings (when enabled): accept `<C-f>`, accept word `<C-w>`, accept line `<C-l>`, reject `<C-r>`, prev/next `<C-p>`/`<C-n>`.

See [AGENTS.md](AGENTS.md) for development notes and agent operations.
