local command = {}

local cmd = vim.cmd

command._callbacks = {}

---@class CommandOptions
---@field public buffer string
---@field public nargs string

---@param lhs string @command string
---@param rhs string|function @action command or function
---@param opts CommandOptions @whether the command is buffer local
function command.command(lhs, rhs, opts)
  local action = rhs
  if type(rhs) == "function" then
    local callback_index = #command._callbacks + 1
    command._callbacks[callback_index] = rhs
    action = "lua require('nacro.utils.command')._callbacks[" .. callback_index .. "]('<args>')"
  end
  local opts_str
  if opts then
    local buffer = opts.buffer and "-buffer" or ""
    local nargs = opts.nargs and ("-nargs=" .. opts.nargs) or ""
    opts_str = table.concat({ buffer, nargs }, " ")
  end
  cmd(("command! %s %s %s"):format(opts_str or "", lhs, action))
end

setmetatable(command, {
  __call = function(tbl, ...)
    tbl.command(...)
  end,
})

return command
