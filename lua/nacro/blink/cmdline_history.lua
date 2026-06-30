-- Custom blink.cmp source for cmdline history
-- History items are sorted by recency (most recent first)

local source = {}

function source.new()
  return setmetatable({}, { __index = source })
end

-- Only enable in cmdline mode
function source:enabled()
  local cmdtype = vim.fn.getcmdtype()
  return cmdtype == ":" or cmdtype == "@"
end

function source:get_completions(ctx, callback)
  local hist_type = ":"
  local seen_items = {}
  local items = {}
  local total = vim.fn.histnr(hist_type)
  local max_length = 200 -- Ignore commands longer than this

  -- Add history items (most recent first)
  for i = 1, total do
    local cmd = vim.fn.histget(hist_type, -i)
    -- Strip leading colons if present
    cmd = cmd:gsub("^:+", "")

    if #cmd > 0 and #cmd <= max_length and not seen_items[cmd] then
      seen_items[cmd] = true
      table.insert(items, {
        label = cmd,
        kind = require("blink.cmp.types").CompletionItemKind.Event,
        kind_icon = "󰋚",
        kind_name = "History",
        sortText = string.format("0_%010d", total - i + 1), -- Recent items at bottom (near cursor)
        insertText = cmd,
      })
    end
  end

  callback({
    items = items,
    is_incomplete_backward = false,
    is_incomplete_forward = false,
  })
end

return source
