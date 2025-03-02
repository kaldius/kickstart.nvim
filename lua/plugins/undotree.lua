-- TODO: in vsplit panes, moving to the undotree pane changes focus of undo
return {
  'mbbill/undotree',
  config = function()
    vim.keymap.set('n', '<leader>ut', vim.cmd.UndotreeToggle)
  end,
}
