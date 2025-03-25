local M = {}

local function get_default_json_parser()
  -- check if json5 is available
  local ok, json5 = pcall(require, "json5")
  if ok then
    return json5.parse
  else
    -- if json5 not available, fall back to vim's default JSON parser
    vim.notify("[nvim-gas] json5 parser not found. Using standard JSON parser.", vim.log.levels.WARN)
    return vim.fn.json_decode
  end
end

local default_config = {
  parse = get_default_json_parser(),
}

-- setup function to configure the plugin
M.setup = function(opts)
  opts = opts or {}
  M.config = default_config

  -- merge user config with default
  if opts.parse ~= nil then
    M.config.parse = opts.parse
  end

  M.setup_gopls()
end

function M.setup_gopls()
  local lspconfig = require("lspconfig")
  local gas_gopls = require("nvim-gas.gas-gopls")
  gas_gopls.parse = M.config.parse

  -- extract existing user settings and inject gas-specific settings
  local existing_config = lspconfig.gopls.document_config or {}
  local user_settings = existing_config.settings or {}
  local gopls_settings = user_settings.gopls or {}

  -- run gopls setup
  lspconfig.gopls.setup(vim.tbl_deep_extend("force", existing_config, {
    settings = {
      gopls = gas_gopls.get_settings(gopls_settings),
    },
    on_init = function(client, _)
      gas_gopls.on_init(existing_config.on_init, client)
    end,
  }))
end

return M
