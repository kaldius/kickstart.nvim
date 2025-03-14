return {
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  ft = { "markdown" },
  build = function() vim.fn["mkdp#util#install"]() end,
  config = function()
    vim.g.mkdp_page_title = '「${name}」'
    vim.g.mkdp_auto_close = 0
    vim.g.mkdp_combine_preview = 1
    vim.keymap.set("n", "<leader>md", ":MarkdownPreviewToggle<CR>", { desc = "Toggle [m]ark[d]own previewer" })
  end
}
