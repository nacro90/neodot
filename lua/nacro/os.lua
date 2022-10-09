local os = {}

local uv = vim.loop

---@alias OperatingSystem '"linux"' | '"mac"'

---@type table<string, OperatingSystem>
local sysname_os_map = {
  Linux = "linux",
  Darwin = "mac",
}

---@return OperatingSystem
function os.get_name()
  local sysname = uv.os_uname().sysname
  return sysname_os_map[sysname]
end

return os
