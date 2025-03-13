-- NOTE:
--Use `:autocmd <event_name>` to query all autocmds that are triggered by the event.
--
-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Show diagnostics in a pop-up window on hover
vim.api.nvim_create_autocmd({ 'CursorHold' }, {
  desc = 'Show diagnostics in a pop-up window on hover',
  group = vim.api.nvim_create_augroup('reset_group', {}),
  callback = function()
    local current_cursor = vim.api.nvim_win_get_cursor(0)
    local last_popup_cursor = vim.w.lsp_diagnostics_last_cursor or { nil, nil }

    -- Show the popup diagnostics window,
    -- but only once for the current cursor location (unless moved afterwards).
    if not (current_cursor[1] == last_popup_cursor[1] and current_cursor[2] == last_popup_cursor[2]) then
      vim.w.lsp_diagnostics_last_cursor = current_cursor
      vim.diagnostic.open_float(nil, {
        scope = 'cursor', -- "cursor"/"line"/"buffer" dictating what diagnostics should show up
        focusable = false,
      })
    end
  end,
})

-- Automatically cd into the directory if nvim is opened with one argument
-- For both cases:
-- 1. `nvim <dir>` and
-- 2. `nvim <dir>/<filename>`,
-- vim.fn.getcwd() will return `<dir>`
vim.api.nvim_create_autocmd('VimEnter', {
  callback = function()
    local arg = vim.fn.argv(0)
    if arg and arg ~= '' and type(arg) == 'string' then
      if vim.fn.isdirectory(arg) == 1 then
        -- If the argument is a directory, change to that directory
        vim.cmd('cd ' .. vim.fn.fnamemodify(arg, ':p'))
      elseif vim.fn.filereadable(arg) == 1 then
        -- If the argument is a file, change to its directory
        local file_dir = vim.fn.fnamemodify(arg, ':h')
        vim.cmd('cd ' .. file_dir)
      end
    end
  end,
})
