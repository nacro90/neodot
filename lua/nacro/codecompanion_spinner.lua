local M = {}

M.active = false
M.frames = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
M.index = 1

function M.start()
  M.active = true
end

function M.stop()
  M.active = false
  M.index = 1
end

function M.get()
  if not M.active then
    return ""
  end
  local frame = M.frames[M.index]
  M.index = (M.index % #M.frames) + 1
  return frame .. " "
end

return M
