-- A hairline statusline to match the fill-less tmux bar: a thin rule like a
-- pane border, with the file and its state set into the line. The rule
-- itself is the fillchars `stl` padding, so it stretches to any width.
local accent = require('core.host').accent

local M = {}

local BG = '#282c34'
local BORDER = '#3b4048'

local mode_colours = {
  i = '#61afef',
  v = '#c678dd', V = '#c678dd', ['\22'] = '#c678dd',
  R = '#e06c75',
}

local plain_filetypes = { NvimTree = true, TelescopePrompt = true }

local function rule(fg)
  vim.api.nvim_set_hl(0, 'StatusLine', { fg = fg, bg = BG })
end

local function apply()
  rule(mode_colours[vim.fn.mode():sub(1, 1)] or BORDER)
  vim.api.nvim_set_hl(0, 'StatusLineNC', { fg = BORDER, bg = BG })
  local groups = {
    HairDir = { fg = '#7f848e' },
    HairFile = { fg = '#abb2bf', bold = true },
    HairModified = { fg = accent },
    HairError = { fg = '#e06c75' },
    HairWarn = { fg = '#e5c07b' },
    HairAdded = { fg = '#98c379' },
    HairChanged = { fg = '#61afef' },
    HairRemoved = { fg = '#e06c75' },
    HairPos = { fg = '#5c6370' },
  }
  for name, spec in pairs(groups) do
    spec.bg = BG
    vim.api.nvim_set_hl(0, name, spec)
  end
end

local function hl(group, text)
  return '%#' .. group .. '#' .. text .. '%#StatusLine#'
end

local function esc(s)
  return (s:gsub('%%', '%%%%'))
end

local function file_part()
  if vim.bo.buftype ~= '' then
    return hl('HairFile', '%t')
  end
  local name = vim.fn.expand('%:t')
  if name == '' then
    return hl('HairFile', '[No Name]')
  end
  local dir = vim.fn.expand('%:~:.:h')
  local out = (dir ~= '.' and dir ~= '') and hl('HairDir', esc(dir) .. '/') or ''
  return out .. hl('HairFile', esc(name))
end

local function right_part()
  local items = {}
  local diag = vim.diagnostic.count(0)
  local errors = diag[vim.diagnostic.severity.ERROR] or 0
  local warns = diag[vim.diagnostic.severity.WARN] or 0
  if errors > 0 then table.insert(items, hl('HairError', '✕ ' .. errors)) end
  if warns > 0 then table.insert(items, hl('HairWarn', '▲ ' .. warns)) end

  local git = vim.b.gitsigns_status_dict
  if git then
    local diff = {}
    if (git.added or 0) > 0 then table.insert(diff, hl('HairAdded', '+' .. git.added)) end
    if (git.changed or 0) > 0 then table.insert(diff, hl('HairChanged', '~' .. git.changed)) end
    if (git.removed or 0) > 0 then table.insert(diff, hl('HairRemoved', '-' .. git.removed)) end
    if #diff > 0 then table.insert(items, table.concat(diff, ' ')) end
  end

  table.insert(items, hl('HairPos', '%l:%c'))
  return table.concat(items, '  ')
end

function M.render()
  if plain_filetypes[vim.bo.filetype] then
    return '%='
  end
  local modified = vim.bo.modified and (' ' .. hl('HairModified', '●')) or ''
  return '──╴ %<' .. file_part() .. modified .. ' ╶%=╴ ' .. right_part() .. ' ╶──'
end

vim.o.laststatus = 3
vim.opt.fillchars:append({ stl = '─', stlnc = '─' })
vim.o.statusline = "%!v:lua.require'core.statusline'.render()"
apply()

local group = vim.api.nvim_create_augroup('HairlineStatus', { clear = true })
vim.api.nvim_create_autocmd('ColorScheme', { group = group, callback = apply })
vim.api.nvim_create_autocmd('ModeChanged', {
  group = group,
  callback = function()
    rule(mode_colours[vim.v.event.new_mode:sub(1, 1)] or BORDER)
  end,
})
vim.api.nvim_create_autocmd('DiagnosticChanged', {
  group = group,
  command = 'redrawstatus',
})
vim.api.nvim_create_autocmd('User', {
  group = group,
  pattern = 'GitSignsUpdate',
  command = 'redrawstatus',
})

return M
