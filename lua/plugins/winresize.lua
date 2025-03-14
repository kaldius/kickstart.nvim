return {
  "pogyomo/winresize.nvim",
  config = function()
    local resize = function(win, amt, dir)
      return function()
        require("winresize").resize(win, amt, dir)
      end
    end
    vim.keymap.set("n", "<left>", resize(0, 10, "left"))
    vim.keymap.set("n", "<right>", resize(0, 10, "right"))
    vim.keymap.set("n", "<up>", resize(0, 5, "up"))
    vim.keymap.set("n", "<down>", resize(0, 5, "down"))

    vim.keymap.set("n", "<S-left>", resize(0, 2, "left"))
    vim.keymap.set("n", "<S-right>", resize(0, 2, "right"))
    vim.keymap.set("n", "<S-up>", resize(0, 1, "up"))
    vim.keymap.set("n", "<S-down>", resize(0, 1, "down"))
  end
}
