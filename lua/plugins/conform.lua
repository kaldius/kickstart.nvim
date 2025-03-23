local state_file = vim.fn.stdpath('state') .. '/format_on_save.lua'

-- Load the persisted state
local function load_format_on_save()
  local f = io.open(state_file, 'r')
  if f then
    local value = f:read('*a')
    f:close()
    return value == 'true'
  end
  return true -- Default to true if file does not exist
end

-- Save the state to a file
local function save_format_on_save(value)
  local f = io.open(state_file, 'w')
  if f then
    f:write(value and 'true' or 'false')
    f:close()
  end
end

-- Autoformat toggle
vim.g.should_format_on_save = load_format_on_save()

vim.keymap.set('n', '<leader>fos', function()
  vim.g.should_format_on_save = not vim.g.should_format_on_save
  save_format_on_save(vim.g.should_format_on_save)
end, { desc = 'Toggle [f]ormat [o]n [s]ave' })

return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  config = function()
    require('conform').setup({
      notify_on_error = false,
      format_on_save = function(bufnr)
        if not vim.g.should_format_on_save then
          return nil
        end

        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. Add additional languages
        -- as required.
        local disable_filetypes = { c = true, cpp = true }
        local lsp_format_opt
        if disable_filetypes[vim.bo[bufnr].filetype] then
          lsp_format_opt = 'never'
        else
          lsp_format_opt = 'fallback'
        end
        return {
          timeout_ms = 500,
          lsp_format = lsp_format_opt,
        }
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        markdown = { 'prettier' },
        -- Conform can also run multiple formatters sequentially
        -- python = { "isort", "black" },
        --
        -- You can use 'stop_after_first' to run the first available formatter from the list
        -- javascript = { "prettierd", "prettier", stop_after_first = true },
      },
    })
  end
}
