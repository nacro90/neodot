local howdoi = {}

local Job = require "plenary.job"

function howdoi.get(arg)
  if vim.fn.executable("howdoi") ~= 1 then
    vim.notify("howdoi executable not found")
    return
  end
  local job = Job:new {
    command = "howdoi",
    args = { arg },
  }
  job:sync()
  return table.concat(job:result(), "\n")
end

function howdoi.setup()
  vim.api.nvim_create_user_command("Howdoi", function(keys)
    local result = howdoi.get(keys.args)
    print(result)
  end, {
    nargs = "+",
  })
end

return howdoi
