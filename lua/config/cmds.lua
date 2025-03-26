-- vim.api.nvim_create_user_command("SpkitBuild", function()
--   local height = math.floor(vim.o.lines * 0.2) -- 20% of the screen height
--   vim.cmd("botright split | resize " .. height .. " | terminal spkit build")
--   vim.cmd("wincmd p")
-- end, {})

--- Executes a command in a new terminal split.
-- @param split_direction (string) "h" for horizontal split, "v" for vertical split.
-- @param percent(number) The size of the split as a percentage of the screen (e.g., 20 for 20%).
-- @param keep_focus (bool) If true, keeps focus in the original window.
-- @param autoclose (bool) If true, closes the terminal window once the process finishes with exit code 0.
-- @param cmd (string) The shell command to run in the terminal.
local function execute_command(split_direction, percent, keep_focus, autoclose, cmd)
  if cmd == "" then
    vim.notify("Error: No command provided", vim.log.levels.ERROR)
    return
  end

  local size
  local split_cmd
  local resize_cmd

  if split_direction == "h" then
    size = math.floor(vim.o.lines * (percent / 100))
    split_cmd = "botright split"
    resize_cmd = "resize "
  elseif split_direction == "v" then
    size = math.floor(vim.o.columns * (percent / 100))
    split_cmd = "botright vsplit"
    resize_cmd = "vertical resize "
  else
    vim.notify(
      "Error: split_direction can only be \"h\" or \"v\", received \"" .. split_direction .. "\"",
      vim.log.levels.ERROR
    )
    return
  end

  vim.cmd(split_cmd)
  vim.cmd(resize_cmd .. size)
  vim.cmd("terminal " .. cmd)

  if autoclose then
    -- Get the current buffer number (the terminal buffer)
    local bufnr = vim.api.nvim_get_current_buf()

    vim.api.nvim_create_autocmd("TermClose", {
      pattern = "*",
      once = true,
      callback = function(args)
        -- Only close if its this specific window buffer
        if args.buf == bufnr then
          local exit_status = vim.api.nvim_get_vvar("event").status
          if exit_status == 0 then
            vim.api.nvim_buf_delete(bufnr, { force = true })
          end
        end
      end
    })
  end

  if keep_focus then
    vim.cmd("wincmd p") -- Return focus to original window
  end
end

--- User command to run a shell command in a terminal split.
-- Usage: :RunCommand <direction> <percentage> <command>
-- @param <split_direction> "h" for horizontal split, "v" for vertical split.
-- @param <percent> The split size as a percentage of the screen.
-- @param <keep_focus> "true" to stay in the original window, "false" to switch focus.
-- @param <autoclose> "true" to close terminal window after finishing with exit code 0, "false" to keep it open.
-- @param <command> The command to execute in the terminal.
vim.api.nvim_create_user_command("RunCommand", function(opts)
  local args = vim.split(opts.args, " ")
  local direction = args[1] or "h"
  local percentage = tonumber(args[2]) or 20
  local keep_focus = args[3] == "true"
  local autoclose = args[4] == "true"
  local cmd = table.concat(vim.list_slice(args, 5), " ") -- everything else is taken as the command

  execute_command(direction, percentage, keep_focus, autoclose, cmd)
end, { nargs = "+" }) -- Require at least one argument (the command itself)

--- Wrapper command for running "spkit build" in a split terminal
-- Usage: :SpkitBuild [additional arguments]
vim.api.nvim_create_user_command("SpkitBuild", function(opts)
  execute_command("h", 20, true, true, "spkit build" .. opts.args)
end, { nargs = "*" }) -- Allow extra args
