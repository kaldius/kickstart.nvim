-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- Global variable to tell lua to look for <library_name>.dylib files in every path that it searches for c libraries
package.cpath = package.cpath .. ';?.dylib'

require 'config.options'
require 'config.keymaps'
require 'config.autocmds'
require 'config.lazy'

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
