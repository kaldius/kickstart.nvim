-- TODO: consider using other plugins from mini
return { -- Collection of various small independent plugins/modules
  'echasnovski/mini.nvim',
  config = function()
    -- Better Around/Inside textobjects
    --
    -- Examples:
    --  - va)  - [V]isually select [A]round [)]paren
    --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
    --  - ci'  - [C]hange [I]nside [']quote
    require('mini.ai').setup { n_lines = 500 }

    -- Add/delete/replace surroundings (brackets, quotes, etc.)
    --
    -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
    -- - sd'   - [S]urround [D]elete [']quotes
    -- - sr)'  - [S]urround [R]eplace [)] [']
    require('mini.surround').setup()

    -- Simple and easy statusline.
    --  You could remove this setup call if you don't like it,
    --  and try some other statusline plugin
    local statusline = require 'mini.statusline'
    -- set use_icons to true if you have a Nerd Font
    statusline.setup { use_icons = vim.g.have_nerd_font }

    -- You can configure sections in the statusline by overriding their
    -- default behavior. For example, here we set the section for
    -- cursor location to LINE:COLUMN
    ---@diagnostic disable-next-line: duplicate-set-field
    statusline.section_location = function()
      return '%2l:%-2v'
    end

    --
    -- Session Management
    --
    require('mini.sessions').setup()

    local function get_session_name()
      -- Get the directory where Neovim was opened, falling back to the current directory
      local dir = vim.fn.argv()[1] or vim.fn.getcwd()
      -- Remove leading period if present (for hidden directories)
      dir = dir:match '^%.' and dir:sub(2) or dir
      -- Replace all slashes with dashes, removing leading slash if present
      return dir:sub(1, 1) == '/' and dir:sub(2):gsub('/', '-') or dir:gsub('/', '-')
    end

    vim.keymap.set('n', '<leader>sw', function()
      MiniSessions.write(get_session_name())
    end, { desc = '[S]ession [W]rite' })

    vim.keymap.set('n', '<leader>sr', function()
      MiniSessions.read(get_session_name())
    end, { desc = '[S]ession [R]ead' })

    --
    -- Animation for vim movements
    --
    local animate = require 'mini.animate'
    animate.setup {
      scroll = {
        timing = animate.gen_timing.linear { duration = 5, unit = 'step' },
        subscroll = animate.gen_subscroll.equal { max_output_steps = 120 }, -- number of steps in animation (smoothness)
      },
    }

    -- Disable by default
    vim.g.minianimate_disable = true

    vim.keymap.set('n', '<leader>ae', function()
      vim.g.minianimate_disable = false
    end, { desc = '[A]nimate [E]nable' })

    vim.keymap.set('n', '<leader>ad', function()
      vim.g.minianimate_disable = true
    end, { desc = '[A]nimate [D]isable' })

    -- ... and there is more!
    --  Check out: https://github.com/echasnovski/mini.nvim
  end,
}
