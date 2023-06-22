local os = {}

local uv = vim.loop

---@alias OperatingSystem '"linux"' | '"mac"'

---@type table<string, OperatingSystem>
local sysname_os_map = {
  Linux = "linux",
  Darwin = "mac",
}

local openers_by_os = {
  ["Linux"] = "xdg-open",
  ["Darwin"] = "open",
}

---@return OperatingSystem
function os.get_name()
  local sysname = uv.os_uname().sysname
  return sysname_os_map[sysname]
end

function os.get_opener()
  return openers_by_os[uv.os_uname().sysname]
end

return os
