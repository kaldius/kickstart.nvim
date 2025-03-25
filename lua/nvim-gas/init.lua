local M = {}

function M.setup(opts)
  opts = opts or {}
  require("nvim-gas.config").setup(opts)
end

return M
