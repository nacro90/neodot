local functional = {}

---@alias Predicate fun(input:any):boolean

local flatten = vim.tbl_flatten

function functional.foldl(func, ...)
  local list = flatten { ... }
  local current = list[1]
  for i = 2, #list do
    current = func(current, list[i])
  end
  return current
end

function functional.foldr(func, ...)
  local list = flatten { ... }
  local current = list[#list]
  for i = 1, #list - 1 do
    current = func(current, list[i])
  end
  return current
end

functional.reduce = functional.foldl

function functional.compose(...)
  local funcs = { ... }
  return function(...)
    local func = funcs[#funcs]
    local retvals = { func(...) }
    for i = #funcs - 1, 1, -1 do
      func = funcs[i]
      retvals = { func(unpack(retvals)) }
    end
    return retvals
  end
end


---And operation to predicates
---@vararg Predicate
---@return Predicate
function functional.and_(...)
  return functional.foldl(function(f1, f2)
    return function(...)
      return f1(...) and f2(...)
    end
  end, ...)
end

return functional
