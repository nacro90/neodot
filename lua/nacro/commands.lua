local M = {}

local command = require "nacro.utils.command"
local api = vim.api
local fn = vim.fn

function M.setup()
  -- Debug/Development
  command("LuaHas", function(keys)
    vim.notify(vim.inspect(pcall(require, keys.args)))
  end, { nargs = 1 })

  -- Editing utilities
  command("RemoveTrailingWhitespace", [[silent! %substitute/\s\+$//]], { nargs = 0 })

  command("RenameBuffer", function(arg)
    local name
    if arg and #arg > 0 then
      name = arg
    else
      name = fn.input "Buffer name: "
      if not name or #name == 0 then
        return
      end
    end
    api.nvim_buf_set_name(0, name)
  end, { nargs = "?" })

  command("TimestampToDatetime", function(a)
    a = a.args
    print(os.date("%Y-%m-%d %H:%M:%S", a / 1000) .. "." .. a % 1000)
  end, { nargs = 1 })

  -- Typo corrections
  command("W", "w")
  command("Q", "q")
  command("Wq", "wq")
  command("WQ", "wq")
end

return M
