-- plugins/telescope.lua:
local policy_file = vim.fn.stdpath('state') .. '/telescope_search_policy.json'

local default_policy = {
  allow_globs = {
  },
  exclude_globs = {
    '.git/**',
  },
}

local search_policy = {
  allow_globs = {},
  exclude_globs = {},
}

local function trim(value)
  return value:match('^%s*(.-)%s*$')
end

local function unique_non_empty(items)
  local unique = {}
  local seen = {}

  for _, item in ipairs(items or {}) do
    local normalized = trim(item)
    if normalized ~= '' and not seen[normalized] then
      seen[normalized] = true
      table.insert(unique, normalized)
    end
  end

  return unique
end

local function ensure_git_excluded(exclude_globs)
  local output = unique_non_empty(exclude_globs)
  local has_git = false

  for _, pattern in ipairs(output) do
    if pattern == '.git/**' then
      has_git = true
      break
    end
  end

  if not has_git then
    table.insert(output, 1, '.git/**')
  end

  return output
end

local function normalize_policy(policy)
  local normalized = policy or {}
  return {
    allow_globs = unique_non_empty(normalized.allow_globs),
    exclude_globs = ensure_git_excluded(normalized.exclude_globs),
  }
end

local function parse_csv_globs(input)
  if not input or trim(input) == '' then
    return {}
  end

  local parsed = {}
  for item in string.gmatch(input, '[^,]+') do
    table.insert(parsed, item)
  end

  return unique_non_empty(parsed)
end

local function save_policy()
  local parent = vim.fn.fnamemodify(policy_file, ':h')
  vim.fn.mkdir(parent, 'p')

  local file, err = io.open(policy_file, 'w')
  if not file then
    vim.notify('Failed to save Telescope policy: ' .. tostring(err), vim.log.levels.ERROR)
    return
  end

  file:write(vim.json.encode(search_policy))
  file:close()
end

local function load_policy()
  local file = io.open(policy_file, 'r')
  if not file then
    search_policy = normalize_policy(default_policy)
    return
  end

  local content = file:read('*a')
  file:close()

  local ok, parsed = pcall(vim.json.decode, content)
  if ok and type(parsed) == 'table' then
    search_policy = normalize_policy(parsed)
  else
    search_policy = normalize_policy(default_policy)
  end
end

local function globs_to_string(globs)
  return table.concat(globs, ', ')
end

local function set_allow_globs()
  vim.ui.input({
    prompt = 'Telescope include globs (comma-separated): ',
    default = globs_to_string(search_policy.allow_globs),
  }, function(input)
    if input == nil then
      return
    end

    search_policy.allow_globs = parse_csv_globs(input)
    search_policy.exclude_globs = ensure_git_excluded(search_policy.exclude_globs)
    save_policy()
    vim.notify('Telescope include globs updated', vim.log.levels.INFO)
  end)
end

local function set_exclude_globs()
  vim.ui.input({
    prompt = 'Telescope exclude globs (comma-separated): ',
    default = globs_to_string(search_policy.exclude_globs),
  }, function(input)
    if input == nil then
      return
    end

    search_policy.exclude_globs = ensure_git_excluded(parse_csv_globs(input))
    save_policy()
    vim.notify('Telescope exclude globs updated (.git/** always excluded)', vim.log.levels.INFO)
  end)
end

local function reset_glob_policy()
  search_policy = normalize_policy(default_policy)
  save_policy()
  vim.notify('Telescope glob policy reset to defaults', vim.log.levels.INFO)
end

local function show_glob_policy()
  local include = globs_to_string(search_policy.allow_globs)
  local exclude = globs_to_string(search_policy.exclude_globs)

  if include == '' then
    include = '(none)'
  end

  if exclude == '' then
    exclude = '(none)'
  end

  vim.notify('Telescope policy\nInclude: ' .. include .. '\nExclude: ' .. exclude, vim.log.levels.INFO)
end

local function build_rg_glob_args()
  local args = {}

  for _, pattern in ipairs(search_policy.exclude_globs) do
    table.insert(args, '--glob')
    table.insert(args, '!' .. pattern)
  end

  for _, pattern in ipairs(search_policy.allow_globs) do
    table.insert(args, '--glob')
    table.insert(args, pattern)
  end

  return args
end

local function find_files_with_policy()
  local builtin = require('telescope.builtin')
  local find_command = { 'rg', '--files', '--hidden', '--no-ignore' }

  vim.list_extend(find_command, build_rg_glob_args())

  builtin.find_files({
    find_command = find_command,
  })
end

local function live_grep_with_policy()
  local builtin = require('telescope.builtin')

  builtin.live_grep({
    additional_args = function()
      local args = { '--hidden', '--no-ignore' }
      vim.list_extend(args, build_rg_glob_args())
      return args
    end,
  })
end

load_policy()

return {
  'nvim-telescope/telescope.nvim', tag = 'v0.1.9',
  keys = {
    { '<leader>ff', find_files_with_policy, desc = 'Find Files' },
    { '<leader>fg', live_grep_with_policy,   desc = 'Live Grep' },
    { '<leader>fa', set_allow_globs,         desc = 'Set Include Globs' },
    { '<leader>fx', set_exclude_globs,       desc = 'Set Exclude Globs' },
    { '<leader>fp', show_glob_policy,        desc = 'Show Search Globs' },
    { '<leader>fr', reset_glob_policy,       desc = 'Reset Search Globs' },
    { '<leader>fb', '<cmd>Telescope buffers<cr>',    desc = 'Buffers' },
    { '<leader>fh', '<cmd>Telescope help_tags<cr>',  desc = 'Help Tags' },
  },
  config = function()
    local telescope = require('telescope')
    local actions = require('telescope.actions')
    local action_state = require('telescope.actions.state')

    local function is_absolute(path)
      return path:match('^%a:[/\\]') ~= nil or path:sub(1, 1) == '/'
    end

    local function resolve_entry_path(entry)
      local path = entry.path or entry.filename
      if not path or path == '' then
        return nil
      end

      if entry.cwd and not is_absolute(path) then
        path = entry.cwd .. '/' .. path
      end

      return path
    end

    local function open_multi_or_default(prompt_bufnr)
      local picker = action_state.get_current_picker(prompt_bufnr)
      local multi = picker:get_multi_selection()

      if #multi == 0 then
        actions.select_default(prompt_bufnr)
        return
      end

      actions.close(prompt_bufnr)

      local opened = {}
      for _, entry in ipairs(multi) do
        local path = resolve_entry_path(entry)
        if path and not opened[path] then
          opened[path] = true
          vim.cmd('edit ' .. vim.fn.fnameescape(path))
        end
      end
    end

    telescope.setup({
      defaults = {
        mappings = {
          i = {
            ['<CR>'] = open_multi_or_default,
          },
          n = {
            ['<CR>'] = open_multi_or_default,
          },
        },
      },
    })
  end,
  dependencies = { 'nvim-lua/plenary.nvim' },
}
