local luasnip = require "luasnip"
local common = require "nacro.snippet.common"

local copy = common.copy
local newline = common.newline
local indent = common.indent

local snip = luasnip.s
local subsnip = luasnip.sn
local txt = luasnip.text_node
local ins = luasnip.insert_node
local choice = luasnip.choice_node
local dyn = luasnip.dynamic_node

return {
  snip("append", {
    ins(1),
    txt { " = append(" },
    copy(1),
    txt { ", " },
    ins(2),
    txt { ")" },
  }),

  snip("ernil", {
    txt { "if err != nil {" },
    newline(),
    indent(),
    txt { "return nil, err", "}" },
  }),

  snip("strptr", {
    txt { '&[]string{"' },
    ins(1),
    txt { '"}[0]' },
  }),
}
