return { -- Highlight todo, notes, etc in comments
  'folke/todo-comments.nvim',
  event = 'VimEnter',
  cmd = { 'TodoTelescope' },
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = { signs = false },
  keys = {
    {
      ']t',
      function()
        require('todo-comments').jump_next()
      end,
      desc = 'Next Todo Comment',
    },
    {
      '[t',
      function()
        require('todo-comments').jump_prev()
      end,
      desc = 'Previous Todo Comment',
    },
    { '<leader>ft', '<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>', desc = '[F]ind Critical [T]odos' },
    { '<leader>fT', '<cmd>TodoTelescope<cr>', desc = '[F]ind ALL [T]odos' },
  },
}
