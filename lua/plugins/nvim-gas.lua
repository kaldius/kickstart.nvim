return {
  dir = "~/.config/nvim/lua/nvim-gas/",
  dependencies = {
    -- NOTE: this ensures lspconfig setup is run first
    -- nvim-gas plugin will append stuff to your existing gopls config and set up gopls again.
    "neovim/nvim-lspconfig",
    -- NOTE: required for parsing .vscode/settings.json file, which can sometimes be in json5
    -- It's okay if you don't want to use this, but you must ensure your json files are in standard json.
    {
      'Joakker/lua-json5',
      build = './install.sh', -- Lazy will run this build command in the repo root each time we install/update
    },
  },
  config = function()
    require("nvim-gas").setup()
  end,
}
