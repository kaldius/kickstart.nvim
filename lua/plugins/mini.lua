-- TODO: consider using other plugins from mini
-- TODO: customise statusline
return { -- Collection of various small independent plugins/modules
  {
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
    end
  },
  {
    'echasnovski/mini.animate',
    config = function()
      local persistence = require('utils.persistence')
      local ani_filename = 'minianimate'

      local function enable_animation()
        local animate = require 'mini.animate'
        animate.setup {
          scroll = {
            timing = animate.gen_timing.linear { duration = 5, unit = 'step' },
            subscroll = animate.gen_subscroll.equal { max_output_steps = 120 },
          },
        }
        vim.g.minianimate_disable = false
        persistence.save_state(ani_filename, true)
      end

      local function disable_animation()
        vim.g.minianimate_disable = true
        persistence.save_state('minianimate', false)
      end

      vim.keymap.set('n', '<leader>anm', function()
        if vim.g.minianimate_disable then
          enable_animation()
          print("mini.animate ON")
        else
          disable_animation()
          print("mini.animate OFF")
        end
      end, { desc = '[an]i[m]ate' })

      if persistence.load_state(ani_filename, false) then
        enable_animation()
      else
        disable_animation()
      end
    end
  }
}
