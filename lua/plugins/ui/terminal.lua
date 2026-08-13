-- snacks.nvim — terminal panel (VS Code–like)
-- <leader>p      focus / toggle bottom terminal panel
-- <leader>P      open a new terminal session in that panel
-- <leader>px     close current session (closes split if it was the last)
-- <A-]> / <A-[>  next / prev session
-- <C-h/j/k/l>   unfocus: leave terminal mode and jump to that split

local state = { last = 1 }

---@param term snacks.win
local function term_id(term)
  local meta = vim.b[term.buf].snacks_terminal
  return meta and meta.id or 1
end

local function list_sorted()
  local terms = Snacks.terminal.list()
  table.sort(terms, function(a, b)
    return term_id(a) < term_id(b)
  end)
  return terms
end

local function next_count()
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

local function hide_all()
  for _, t in ipairs(Snacks.terminal.list()) do
    if t:win_valid() then
      t:hide()
    end
  end
end

--- Show one terminal session; hide the others so they share one panel.
---@param term snacks.win
local function show_only(term)
  for _, t in ipairs(Snacks.terminal.list()) do
    if t ~= term and t:win_valid() then
      t:hide()
    end
  end
  if not term:win_valid() then
    term:show()
  end
  term:focus()
  state.last = term_id(term)
  vim.cmd.startinsert()
end

local function focus_terminal()
  local terms = list_sorted()
  local cur = vim.api.nvim_get_current_buf()

  -- Already in a snacks terminal → hide the panel
  for _, t in ipairs(terms) do
    if t.buf == cur and t:win_valid() then
      hide_all()
      return
    end
  end

  -- Panel visible but unfocused → focus the active session
  for _, t in ipairs(terms) do
    if t:win_valid() then
      t:focus()
      state.last = term_id(t)
      vim.cmd.startinsert()
      return
    end
  end

  -- Panel hidden → restore last session, or create the first
  if #terms == 0 then
    Snacks.terminal.open(nil, { count = 1 })
    state.last = 1
    return
  end

  local last = Snacks.terminal.get(nil, { count = state.last, create = false })
  show_only(last or terms[1])
end

local function new_terminal()
  local count = next_count()
  hide_all()
  Snacks.terminal.open(nil, { count = count })
  state.last = count
end

---@param dir integer 1 = next, -1 = prev
local function cycle_terminal(dir)
  local terms = list_sorted()
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
    elseif term_id(t) == state.last then
      idx = i
    end
  end

  local next_idx = ((idx - 1 + dir) % #terms) + 1
  show_only(terms[next_idx])
end

--- Wipe the current (or last) session. If it was the only one, the split closes too.
local function close_terminal()
  local terms = list_sorted()
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
    elseif term_id(t) == state.last then
      current, idx = t, i
    end
  end

  ---@type snacks.win?
  local fallback = nil
  if #terms > 1 then
    fallback = terms[(idx % #terms) + 1]
  end

  -- Force delete the buffer to avoid job exit errors.
  if current and current.buf and vim.api.nvim_buf_is_valid(current.buf) then
    vim.api.nvim_buf_delete(current.buf, { force = true })
  end

  if fallback and fallback:buf_valid() then
    show_only(fallback)
  else
    state.last = 1
  end
end

-- Remember last session when entering a snacks terminal
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  callback = function(ev)
    local meta = vim.b[ev.buf].snacks_terminal
    if meta and meta.id then
      state.last = meta.id
    end
  end,
})

-- Terminal keymaps
vim.keymap.set({ "n", "t" }, "<leader>p", focus_terminal, { desc = "Toggle terminal panel" })
vim.keymap.set({ "n", "t" }, "<leader>P", new_terminal, { desc = "New terminal session" })
vim.keymap.set({ "n", "t" }, "<leader>px", close_terminal, { desc = "Close terminal session" })
vim.keymap.set("t", "<A-]>", function() cycle_terminal(1) end, { desc = "Next terminal session" })
vim.keymap.set("t", "<A-[>", function() cycle_terminal(-1) end, { desc = "Previous terminal session" })

return {}
