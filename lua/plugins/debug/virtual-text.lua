-- Adds variable values as virtual text
return {
  'theHamsta/nvim-dap-virtual-text',
  opts = {
    display_callback = function(variable)
      -- Truncates long values
      if #variable.value > 15 then
        return ' ' .. string.sub(variable.value, 1, 15) .. ' ... '
      end
      return ' ' .. variable.value
    end,
  },
}
