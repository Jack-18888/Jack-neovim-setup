-- snacks.nvim configuration
-- Includes:
-- - Explorer: <leader>t (toggle), <leader>rv (reveal)
-- - Buffer delete: :Bd, <leader>q, <leader>fq
-- - Terminal panel: <C-q> (toggle), <C-w> (new), <C-x> (close), <A-]> (next), <A-[> (prev)
-- - Smooth scroll animations

local terminal_state = { last = 1 }

---@param term snacks.win
local function term_id(term)
  local meta = vim.b[term.buf].snacks_terminal
  return meta and meta.id or 1
end

local function list_sorted_terms()
  local terms = Snacks.terminal.list()
  table.sort(terms, function(a, b)
    return term_id(a) < term_id(b)
  end)
  return terms
end

local function next_term_count()
  local used = {}
  for _, t in ipairs(Snacks.terminal.list()) do
    used[term_id(t)] = true
  end
  local i = 1
  while used[i] do
    i = i + 1
  end
  return i
end

local function hide_all_terms()
  for _, t in ipairs(Snacks.terminal.list()) do
    if t:win_valid() then
      t:hide()
    end
  end
end

--- Show one terminal session; hide the others so they share one panel.
---@param term snacks.win
local function show_only_term(term)
  for _, t in ipairs(Snacks.terminal.list()) do
    if t ~= term and t:win_valid() then
      t:hide()
    end
  end
  if not term:win_valid() then
    term:show()
  end
  term:focus()
  terminal_state.last = term_id(term)
  vim.cmd.startinsert()
end

local function focus_terminal()
  local terms = list_sorted_terms()
  local cur = vim.api.nvim_get_current_buf()

  -- Already in a snacks terminal -> hide the panel
  for _, t in ipairs(terms) do
    if t.buf == cur and t:win_valid() then
      hide_all_terms()
      return
    end
  end

  -- Panel visible but unfocused -> focus the active session
  for _, t in ipairs(terms) do
    if t:win_valid() then
      t:focus()
      terminal_state.last = term_id(t)
      vim.cmd.startinsert()
      return
    end
  end

  -- Panel hidden -> restore last session, or create the first
  if #terms == 0 then
    Snacks.terminal.open(nil, { count = 1 })
    terminal_state.last = 1
    return
  end

  local last = Snacks.terminal.get(nil, { count = terminal_state.last, create = false })
  show_only_term(last or terms[1])
end

local function new_terminal()
  local count = next_term_count()
  hide_all_terms()
  Snacks.terminal.open(nil, { count = count })
  terminal_state.last = count
end

---@param dir integer 1 = next, -1 = prev
local function cycle_terminal(dir)
  local terms = list_sorted_terms()
  if #terms == 0 then
    new_terminal()
    return
  end

  local idx = 1
  local cur = vim.api.nvim_get_current_buf()
  for i, t in ipairs(terms) do
    if t.buf == cur then
      idx = i
      break
    elseif term_id(t) == terminal_state.last then
      idx = i
    end
  end

  local next_idx = ((idx - 1 + dir) % #terms) + 1
  show_only_term(terms[next_idx])
end

--- Wipe the current (or last) session. If it was the only one, the split closes too.
local function close_terminal()
  local terms = list_sorted_terms()
  if #terms == 0 then
    return
  end

  local cur = vim.api.nvim_get_current_buf()
  local idx = 1
  local current = terms[1]
  for i, t in ipairs(terms) do
    if t.buf == cur then
      current, idx = t, i
      break
    elseif term_id(t) == terminal_state.last then
      current, idx = t, i
    end
  end

  ---@type snacks.win?
  local fallback = nil
  if #terms > 1 then
    fallback = terms[(idx % #terms) + 1]
  end

  if current then
    if current.augroup then
      pcall(vim.api.nvim_del_augroup_by_id, current.augroup)
      current.augroup = nil
    end
    if current.buf and vim.api.nvim_buf_is_valid(current.buf) then
      vim.api.nvim_buf_delete(current.buf, { force = true })
    end
  end

  if fallback and fallback:buf_valid() then
    show_only_term(fallback)
  else
    terminal_state.last = 1
  end
end

local function bufdelete(force)
  local current_buf = vim.api.nvim_get_current_buf()
  local ft = vim.bo[current_buf].filetype
  -- Don't close explorer or its layout buffers
  if ft == "snacks_picker_explorer" or ft == "snacks_layout_box" then
    return
  end
  Snacks.bufdelete({ buf = current_buf, force = force })
end

return {
  {
    "folke/snacks.nvim",
    lazy = false,
    priority = 900,
    ---@type snacks.Config
    opts = {
      bufdelete = { enabled = true },
      explorer = { enabled = true, replace_netrw = true },
      scroll = {
        enabled = true,
        animate = {
          duration = { step = 5, total = 80 },
          easing = "linear",
        },
        animate_repeat = {
          delay = 100,
          duration = { step = 3, total = 30 },
          easing = "linear",
        },
      },
      terminal = {
        enabled = true,
        win = {
          style = "terminal",
          position = "bottom",
          height = 0.32,
        },
      },
      picker = {
        enabled = false, -- Lazy load picker on demand instead of at UIEnter
        sources = {
          explorer = {
            focus = "list",
            layout = {
              layout = {
                position = "left",
                width = 35,
                box = "vertical",
                { win = "list" },
              },
            },
            win = {
              list = {
                keys = {
                  ["<leader>rv"] = "explorer_focus",
                },
              },
            },
          },
        },
      },
    },
    init = function()
      -- Track terminal session
      vim.api.nvim_create_autocmd("BufEnter", {
        pattern = "*",
        callback = function(ev)
          local meta = vim.b[ev.buf].snacks_terminal
          if meta and meta.id then
            terminal_state.last = meta.id
          end
        end,
      })

      -- Buffer delete commands
      vim.api.nvim_create_user_command("Bd", function(opts)
        bufdelete(opts.bang)
      end, { bang = true })

      vim.cmd([[cnoreabbrev bd Bd]])
      vim.cmd([[cnoreabbrev bd! Bd!]])
    end,
    keys = {
      -- Explorer
      { "<leader>t", function() Snacks.explorer.open() end, mode = "n", desc = "Toggle file tree" },
      { "<leader>rv", function() Snacks.explorer.reveal() end, mode = "n", desc = "Reveal file in explorer" },

      -- Buffer delete
      { "<leader>q", function() bufdelete(false) end, mode = "n", desc = "Close buffer and split" },
      { "<leader>fq", function() bufdelete(true) end, mode = "n", desc = "Force close buffer and split" },

      -- Terminal panel
      { "<C-q>", focus_terminal, mode = { "n", "t" }, desc = "Toggle terminal panel" },
      { "<C-w>", new_terminal, mode = { "n", "t" }, desc = "New terminal session" },
      { "<C-x>", close_terminal, mode = { "n", "t" }, desc = "Close terminal session" },
      { "<A-]>", function() cycle_terminal(1) end, mode = "t", desc = "Next terminal session" },
      { "<A-[>", function() cycle_terminal(-1) end, mode = "t", desc = "Previous terminal session" },
    },
  },
}
