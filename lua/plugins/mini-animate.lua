return {
  'echasnovski/mini.animate',
  lazy = false,
  version = '*',
  config = function()
    local animate = require 'mini.animate'
    animate.setup {
      cursor = {
        timing = animate.gen_timing.linear { duration = 10, unit = 'step' },
        -- path = animate.gen_path.line {
        --   predicate = function()
        --     return true -- always animate, even if cursor in the same line
        --   end,
        -- },
      },
      scroll = {
        timing = animate.gen_timing.linear { duration = 5, unit = 'step' },
        subscroll = animate.gen_subscroll.equal { max_output_steps = 120 }, -- number of steps in animation (smoothness)
      },
    }
  end,
}
