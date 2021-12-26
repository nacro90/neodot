local btc = {}

local curl = require "plenary.curl"

local uv = vim.loop
local json = vim.json

btc.enabled = true

function btc.toggle()
  btc.enabled = not btc.enabled
end

function btc.is_enabled()
  return btc.enabled
end

function btc.create_component_func(interval)
  interval = interval or 10000
  local current_price

  local function decode_response_and_update(response)
    local status = response.status
    if status < 200 or status >= 300 then
      return
    end

    local body = response.body
    if not body then
      return
    end

    local decoded = json.decode(body)
    current_price = math.floor(decoded.data.amount)
  end

  local function fetch()
    if not btc.enabled then
      return
    end

    local params = {
      url = "https://api.coinbase.com/v2/prices/spot",
      query = { currency = "USD" },
      callback = decode_response_and_update,
    }
    pcall(curl.get, params)
  end

  local timer = uv.new_timer()
  timer:start(0, interval, fetch)

  return function()
    local output = "BTC: $" .. (current_price or "")
    return current_price and output or ""
  end
end

return btc
