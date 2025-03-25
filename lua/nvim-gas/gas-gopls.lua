local M = {}

local vscode_settings_path = ".vscode/settings.json"
local parse = require('nvim-gas.config').parse or vim.fn.json_decode

local function _get_modfile_path()
  -- check for existence
  if vim.fn.filereadable(vscode_settings_path) == 0 then
    return nil
  end

  local content = vim.fn.readfile(vscode_settings_path)
  local ok, decoded = pcall(parse, table.concat(content, "\n"))

  if not ok or not decoded then
    return nil
  end

  if decoded["go.buildFlags"] then
    -- the value should be an array, so loop through and find `-modfile=...`
    for _, flag in ipairs(decoded["go.buildFlags"]) do
      local modfile_path = flag:match("^-modfile=(.+)$")
      if modfile_path then
        return modfile_path
      end
    end
  end

  return nil
end

function M.get_settings(existing_settings)
  existing_settings.buildFlags = existing_settings.buildFlags or {}

  local modfile_path = _get_modfile_path()

  if modfile_path == nil then
    return existing_settings
  end

  local found = false

  -- check if `-modfile` already exists and overwrite it
  for i, flag in ipairs(existing_settings.buildFlags) do
    if flag:match("^-modfile=") then
      existing_settings.buildFlags[i] = "-modfile=" .. modfile_path
      found = true
      break
    end
  end

  -- if no existing -modfile flag was found, just append
  if not found then
    table.insert(existing_settings.buildFlags, "-modfile=" .. modfile_path)
  end

  return existing_settings
end

function M.on_init(existing_on_init, client)
  if existing_on_init ~= nil then
    -- run user's on_init first
    existing_on_init(client)
  end

  local gen_go_path = vim.fn.getcwd() .. "/.vscode/gas/gen.go"

  if vim.fn.filereadable(gen_go_path) == 1 then
    local uri = "file://" .. gen_go_path

    client.notify("textDocument/didOpen", {
      textDocument = {
        uri = uri,
        languageId = "go",
        version = 1,
        text = table.concat(vim.fn.readfile(gen_go_path), "\n"),
      }
    })
  end
end

return M
