-- DAP config for go
return {
  'mcoqzeug/nvim-dap-go', -- NOTE: Requires delve to be installed
  opts = {
    dap_configurations = {
      {
        type = 'go',
        name = 'Debug (Env Vars)',
        request = 'launch',
        program = '${file}',
      },
    },
    delve = {
      -- On Windows delve must be run attached or it crashes.
      -- See https://github.com/leoluz/nvim-dap-go/blob/main/README.md#configuring
      detached = vim.fn.has 'win32' == 0,
    },
  }
}
