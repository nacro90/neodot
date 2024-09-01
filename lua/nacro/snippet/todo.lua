local luasnip = require "luasnip"
local common = require "nacro.snippet.common"

local cp = common.copy
local nl = common.newline
local indent = common.indent

local s = luasnip.s
local sn = luasnip.sn
local t = luasnip.text_node
local i = luasnip.insert_node
local c = luasnip.choice_node
local f = luasnip.function_node
local d = luasnip.dynamic_node

local one_day_ms = 24 * 60 * 60

return {
  s("tomorrow", {
    f(function()
      return os.date("%Y-%m-%d", os.time() + one_day_ms)
    end),
  }),
  s("today", {
    f(function()
      return os.date "%Y-%m-%d"
    end),
  }),
}
