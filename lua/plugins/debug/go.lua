-- DAP config for go
-- NOTE: Requires delve to be installe
return {
  -- TODO: using a dev branch that hasn't been merged, eventually switch back to original
  -- 'leoluz/nvim-dap-go',
  'mcoqzeug/nvim-dap-go',
  branch = 'set-cwd-for-dlv',
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
