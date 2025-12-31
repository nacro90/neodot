-- Custom cmdline_history source with proper sorting
local source = {}

function source.new()
  return setmetatable({}, { __index = source })
end

function source:get_keyword_pattern()
  return ".*"
end

function source:complete(request, callback)
  local hist_type = request.option.history_type or vim.fn.getcmdtype()
  local seen_items = {}
  local items = {}
  local total = vim.fn.histnr(hist_type)

  local max_length = 200 -- Ignore commands longer than this
  for i = 1, total do
    local item = vim.fn.histget(hist_type, -i)
    if #item > 0 and #item <= max_length and not seen_items[item] then
      seen_items[item] = true
      items[#items + 1] = {
        label = item,
        sortText = string.format("%010d", i), -- Ensures correct ordering
        dup = 0,
      }
    end
  end

  callback({ items = items })
end

return source
