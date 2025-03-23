local M = {}

local function get_state_file(name)
  return vim.fn.stdpath('state') .. '/' .. name .. '.lua'
end

function M.load_state(name, default)
  local file = get_state_file(name)
  local f = io.open(file, 'r')
  if f then
    local value = f:read('*a')
    f:close()
    return value == 'true'
  end
  return default
end

function M.save_state(name, value)
  local file = get_state_file(name)
  local f = io.open(file, 'w')
  if f then
    f:write(value and 'true' or 'false')
    f:close()
  end
end

return M
