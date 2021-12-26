local highlight = {}

local cmd = vim.cmd

---@class HighlightSpec
---@field public guifg string
---@field public guibg string
---@field public guisp string
---@field public gui string
---@field public ctermbg integer
---@field public ctermfg integer
---@field public blend integer

---Highlight command in lua
---@param group string
---@param specs HighlightSpec
function highlight.hl(group, specs)
  local spec_elements = {}
  for spec_key, spec_value in pairs(specs) do
    table.insert(spec_elements, spec_key .. "=" .. spec_value)
  end
  local spec_str = table.concat(spec_elements, " ")
  cmd(("highlight! %s %s"):format(group, spec_str))
end

---Highilight link command in lua
---@param from_group string
---@param to_group string
function highlight.hl_link(from_group, to_group)
  cmd(("highlight! link %s %s"):format(from_group, to_group))
end

---Unified highlight command in lua
---@param group string
---@param spec_or_group HighlightSpec|string @Link if string, plain highlight if HighlightSpec
function highlight.highlight(group, spec_or_group)
  local t = type(spec_or_group)
  if t == "table" then
    highlight.hl(group, spec_or_group)
  elseif t == "string" then
    highlight.hl_link(group, spec_or_group)
  end
end

setmetatable(highlight, {
  __call = function(tbl, ...)
    tbl.highlight(...)
  end,
})

return highlight
