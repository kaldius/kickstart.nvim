-- DAP config for lua `:help osv`
return {
  -- NOTE: If you see "Neovim is waiting for input at startup. Aborting.", try launching the
  -- server from the empty neovim screen, with no files open
  'jbyuki/one-small-step-for-vimkind',
  lazy = false, -- NOTE: need `lazy = false` else `:OsvLaunch` will not be available
  config = function()
    local dap = require 'dap'
    dap.configurations.lua = {
      {
        type = 'nlua',
        request = 'attach',
        name = "Attach to running Neovim instance",
      }
    }

    dap.adapters.nlua = function(callback, config)
      callback({
        type = 'server',
        host = config.host or "127.0.0.1",
        port = config.port or 8086,
      })
    end

    vim.api.nvim_create_user_command("OsvLaunch", function()
      require "osv".launch({ port = 8086 })
    end, {})
  end
}
