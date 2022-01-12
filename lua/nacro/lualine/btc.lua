local btc = {}

local Job = require "plenary.job"

local uv = vim.loop
local json = vim.json

btc.enabled = false

function btc.toggle()
  btc.enabled = not btc.enabled
end

function btc.is_enabled()
  return btc.enabled
end

function btc.create_component_func(interval)
  interval = interval or 10000
  local current_price

  local function decode_response_and_update(job)
    local response = job:result()[1]
    local decoded = json.decode(response)
    current_price = math.floor(decoded.data.amount)
  end

  local job = Job:new {
    command = "curl",
    args = { "https://api.coinbase.com/v2/prices/spot?currency=USD" },
  }
  job:after_success(decode_response_and_update)

  local function fetch()
    if not btc.enabled then
      return
    end

    job:start()
  end

  local timer = uv.new_timer()
  timer:start(0, interval, fetch)

  return function()
    local output = "BTC: $" .. current_price
    return current_price and output or ""
  end
end

return btc
