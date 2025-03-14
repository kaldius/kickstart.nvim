return {
  'Shatur/neovim-session-manager',
  config = function()
    local Path = require 'plenary.path'
    local manager = require 'session_manager'
    local config = require 'session_manager.config'
    require('session_manager').setup {
      sessions_dir = Path:new(vim.fn.stdpath 'data', 'sessions'), -- The directory where the session files will be saved.
      autoload_mode = config.AutoloadMode.CurrentDir,             -- Define what to do when Neovim is started without arguments.
      autosave_ignore_not_normal = true,                          -- Plugin will not save a session when no buffers are opened, or all of them aren't writable or listed.
      autosave_ignore_dirs = {
        '~',
      }, -- A list of directories where the session will not be autosaved.
      -- autosave_ignore_filetypes = { -- All buffers of these file types will be closed before the session is saved.
      --   'gitcommit',
      --   'gitrebase',
      -- },
      max_path_length = 0, -- Shorten the display path if length exceeds this threshold. Use 0 if don't want to shorten the path at all.
    }

    vim.keymap.set('n', '<leader>sl', manager.load_session, { desc = '[s]ession [l]oad' })
    vim.keymap.set('n', '<leader>sd', manager.delete_session, { desc = '[s]ession [d]elete' })
  end,
}
