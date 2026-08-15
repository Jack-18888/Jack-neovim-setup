# AGENTS.md

Guidance for AI coding agents (and contributors) working on this Neovim configuration. Read this before editing the repo.

## Project snapshot

- Personal Neovim config for Windows 11, written in Lua, plugin-managed by [lazy.nvim](https://github.com/folke/lazy.nvim).
- Current branch: `windows11-config`. Sibling branches `main` and `ubuntu-config` hold other variants — keep OS-specific code on the right branch.
- Every plugin is lazy-loaded by default (`defaults.lazy = true` in `lua/config/lazy.lua`); new plugins should declare explicit lazy triggers (`event`, `cmd`, `keys`, `ft`, or `module`).
- Entry point `init.lua` requires `config.lazy`, `config.keymaps`, and `config.autocmds`. Plugin specs are discovered from `lua/plugins/**` via category imports in `lua/config/lazy.lua`.

## Agent references

| Path | Purpose |
| --- | --- |
| `init.lua` | Entry point: bytecode loader, global options, default colorscheme (catppuccin-frappe) |
| `lua/config/lazy.lua` | lazy.nvim bootstrap, leader keys (`Space`, local `\`), spec imports, performance settings |
| `lua/config/keymaps.lua` | Global keymaps, colorscheme cycling, `:Bd` buffer-close command |
| `lua/config/autocmds.lua` | Filetype indentation: Python 4 spaces; go/cpp/c tabs (width 4); lua/js/ts/json 2 spaces |
| `lua/plugins/editing.lua` | conform (format on save) and nvim-lint (ruff) configuration |
| `lua/plugins/editing/` | Per-plugin files: comment, diffview, flash, gitsigns, neogit, tabout, telescope (file is `telescop.lua`), which-key, ufo/statuscol |
| `lua/plugins/lsp/` | lazydev, mason (tool installer), nvim-cmp, nvim-lspconfig, rustaceanvim, typescript-tools |
| `lua/plugins/ui/` | nvim-tree, bufferline, lualine, alpha dashboard, noice, fidget, tiny-inline-diagnostic |
| `lua/plugins/ai/copilot.lua` | Copilot (suggestions disabled by default) |
| `lua/plugins/debugging/` | nvim-dap + nvim-dap-ui (C/C++ cppdbg configuration) |
| `lua/plugins/treesitter/` | Native treesitter config (Neovim 0.12+): `native-treesitter.lua` enables built-in highlighting via `vim.treesitter.start()` and textobjects (`main` branch of nvim-treesitter-textobjects); `treesitter-manager.lua` manages parser installation via `tree-sitter` CLI |
| `lua/plugins/colorschemes/` | catppuccin (default), tokyonight, vscode, gruvbox-material |
| `lazy-lock.json` | Local plugin lockfile (gitignored) |
| `startup.log` | Startup profiling output (gitignored) |

### Conventions

- One plugin or concern per file under `lua/plugins/<category>/`; new categories must be imported in `lua/config/lazy.lua` (e.g. `{ import = "plugins.ui" }`).
- Prefer lazy triggers over loading everything at startup — this repo deliberately optimizes startup time.
- Add `desc = "..."` to every keymap so which-key and help stay useful.
- Keep global settings in `init.lua`, keymaps in `lua/config/keymaps.lua`, filetype behavior in `lua/config/autocmds.lua`.
- Formatting/linting belong in `lua/plugins/editing.lua` (`formatters_by_ft` / `linters_by_ft`).
- LSP servers: register tools in `lua/plugins/lsp/mason.lua` (`ensure_installed`) and enable/configure them in `lua/plugins/lsp/nvim-lspconfig.lua` via `vim.lsp.config` + `vim.lsp.enable` (Neovim 0.11 API). `automatic_enable = false` — servers are enabled explicitly per language.
- OS-specific paths are hard-coded: MSYS2 UCRT64 toolchain at `D:\msys64\ucrt64\bin` (prepended to PATH on win32 in `init.lua` — provides gcc for tree-sitter and clangd), Python at `C:/Users/T14G3/AppData/Local/Python/pythoncore-3.14-64` (prepended to PATH on win32 in `mason.lua`). The `ubuntu-config` branch carries the Linux equivalents.
- Colorscheme cycle order lives in the `colorschemes` list in `lua/config/keymaps.lua`; catppuccin is the default (priority 1000 in `lua/plugins/colorschemes/catppuccin.lua`).
- Tree-sitter highlighting and indentation are native in Neovim 0.12+ — the `nvim-treesitter` plugin is no longer used. Parsers are managed via `tree-sitter-manager.nvim` (`:TSManager`) or the `tree-sitter` CLI. Textobjects use the `main` branch of `nvim-treesitter-textobjects` with the standalone `require("nvim-treesitter-textobjects").setup({...})` API.

## Operations

- **Add a plugin**: create `lua/plugins/<category>/<name>.lua` returning a spec list (lazy trigger + `config`), add the category import in `lua/config/lazy.lua` if it is new, then install with `:Lazy sync` and verify it loads.
- **Change a keymap**: edit `lua/config/keymaps.lua` for globals; edit the `on_attach` blocks in `lua/plugins/lsp/nvim-lspconfig.lua` or `lua/plugins/lsp/typescript-tools.lua` for LSP bindings.
- **Change indentation rules**: edit the filetype patterns in `lua/config/autocmds.lua`.
- **Add formatting/linting**: extend `formatters_by_ft` / `linters_by_ft` in `lua/plugins/editing.lua`, and add the tools to Mason's `ensure_installed` where applicable.
- **Add a colorscheme**: add a spec under `lua/plugins/colorschemes/` and append it to the `colorschemes` list in `lua/config/keymaps.lua`.
- **Telescope search policy**: persisted at `stdpath('state')/telescope_search_policy.json`; `**/.git/**` is always excluded and the picker runs `rg --files --hidden --no-ignore` plus policy globs. Runtime commands `<leader>fa` / `<leader>fx` / `<leader>fp` / `<leader>fr` manage it.

### Verification

- Load check: `nvim --headless "+qall"` — config errors print to stderr and the exit code is non-zero on load failure.
- Plugin issues: `:checkhealth` and `:Lazy health`; tool installation: `:Mason`; search debugging: `:Telescope`.
- `startup.log` captures startup timing data (gitignored).
- Docs consistency: if you add/move a plugin or change keymaps, update `README.md` (features/keymap table) and this file.

## Pitfalls & gotchas

- `copilot.lua` sets `suggestion.enabled = false` by default — only enable it when the user asks.
- Clipboard is set on the `VeryLazy` event to avoid conflicts with plugin clipboard settings.
- `<Tab>` is already owned by nvim-cmp (menu navigation) and tabout (jump out of pairs); LuaSnip's default Tab binding is deliberately disabled in `lua/plugins/editing/tabout.lua`. Avoid introducing conflicting `<Tab>` maps.
- `<leader><Tab>` jumps to the previous buffer and closes all buffers to its right — bufferline must remain functional for this.
- `:Bd` and `<leader>q` intentionally never close NvimTree buffers (guarded by `filetype == "NvimTree"` in `keymaps.lua`).
- The alpha dashboard button for the terminal still uses `term powershell` while the global keymap uses `term pwsh` — a known inconsistency; align the dashboard if editing it.
- `lazy-lock.json` and `startup.log` are gitignored — do not commit them or depend on the lockfile being shared.
- This is a git repo (origin `Jack-18888/Jack-neovim-setup`) with multiple per-OS branches. Work on the current branch (`windows11-config`) unless the user directs otherwise, and avoid destructive git commands.
