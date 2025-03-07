-- Notes:
-- * `:<mode>map <keys>` shows all mappings for this key combination. use `:<mode>map` alone to see all
--   e.g. `:nmap <C-h>` shows all mappings for <C-h> in normal mode
--   e.g. `:tmap` shows all mappings in terminal mode
local map = vim.keymap.set

-- [[ Basic Keymaps ]]
--  See `:help map()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
map('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
map('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
map('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
map('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
map('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
map('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

--  See `:help wincmd` for a list of all window commands
map('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
map('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
map('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
map('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

map('n', '<C-S-h>', '<C-w>H', { desc = 'Move current window to the left' })
map('n', '<C-S-l>', '<C-w>L', { desc = 'Move current window to the right' })
map('n', '<C-S-j>', '<C-w>J', { desc = 'Move current window to the bottom' })
map('n', '<C-S-k>', '<C-w>K', { desc = 'Move current window to the top' })

map('n', '<leader>pv', ':Ex<CR>', { desc = 'Go to [p]roject [v]iew', silent = true })

map('n', '<leader>th', '<cmd>:horiz term<CR>', { desc = '[T]erminal [H]orizontal' })
map('n', '<leader>tv', '<cmd>:vert term<CR>', { desc = '[T]erminal [V]ertical' })
