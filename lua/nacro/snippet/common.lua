local common = {}

local luasnip = require "luasnip"

local opt = vim.opt

local txt = luasnip.text_node
local subsnip = luasnip.sn
local ins = luasnip.insert_node

--- Removes the necessity of the index argument
function common.fn(func, index, ...)
  return luasnip.function_node(func, index or {}, ...)
end

--- Copies the insert node value with given index
function common.copy(i)
  return common.fn(function(args)
    return args[1][1]
  end, i)
end

--- More verbose new line expression
function common.newline(n)
  n = n or 1
  local lines = { "" }
  for _ = 1, n do
    lines[#lines + 1] = ""
  end
  return txt(lines)
end

function common.indent(n)
  n = n or 1
  local rep = string.rep
  local function indenter()
    local expandtab = opt.expandtab:get()
    local tab_unit = expandtab and rep(" ", opt.shiftwidth:get()) or "\t"
    return rep(tab_unit, n)
  end
  return common.fn(indenter)
end

function common.last_element_as_snip(separator_pattern)
  return function(args)
    local module_name = args[1][1]
    local nodes = vim.split(module_name, separator_pattern)
    return subsnip(nil, { ins(1, nodes[#nodes]) })
  end
end

return common
