local persistence = require('utils.persistence')
local fos_filename = 'format_on_save'

-- Autoformat persistence
vim.g.should_format_on_save = persistence.load_state(fos_filename, true)

vim.keymap.set('n', '<leader>fos', function()
  vim.g.should_format_on_save = not vim.g.should_format_on_save
  persistence.save_state(fos_filename, vim.g.should_format_on_save)
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
