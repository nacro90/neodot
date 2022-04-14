local command = {}

local add_user_command = vim.api.nvim_create_user_command

command._callbacks = {}

---@class CommandOptions
---@field public buffer string
---@field public nargs string

---@param lhs string @command string
---@param rhs string|function @action command or function
---@param opts CommandOptions @whether the command is buffer local
function command.command(lhs, rhs, opts)
  add_user_command(lhs, rhs, opts or {})
end

setmetatable(command, {
  __call = function(tbl, ...)
    tbl.command(...)
  end,
})

return command
