return {
  'ThePrimeagen/harpoon',
  config = function()
    local mark = require('harpoon.mark')
    local ui = require('harpoon.ui')

    vim.keymap.set('n', '<leader>ha', mark.add_file, { desc = '[h]arpoon [a]dd file' })
    vim.keymap.set('n', '<leader>hm', ui.toggle_quick_menu, { desc = '[h]arpoon [m]arks' })

    vim.keymap.set('n', '<C-n>', function() ui.nav_file(1) end)
    vim.keymap.set('n', '<C-m>', function() ui.nav_file(2) end)
    vim.keymap.set('n', '<C-,>', function() ui.nav_file(3) end)
    vim.keymap.set('n', '<C-.>', function() ui.nav_file(4) end)
    vim.keymap.set('n', '<C-/>', function() ui.nav_file(5) end)
  end
}
