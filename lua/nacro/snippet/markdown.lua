local luasnip = require "luasnip"
local common = require "nacro.snippet.common"

local opt = vim.opt

local snip = luasnip.s
local subsnip = luasnip.sn
local txt = luasnip.text_node
local ins = luasnip.insert_node
local choice = luasnip.choice_node
local dyn = luasnip.dynamic_node

local copy = common.copy
local newline = common.newline
local indent = common.indent
local fn = common.fn

return {
  snip({ trig = "---", dscr = "YAML Frontmatter for Zettelkasten" }, {
    txt { "---", "title: " },
    ins(1),
    newline(),
    txt { "date: " },
    fn(function()
      return os.date "%Y-%m-%dT%H:%M"
    end),
    newline(),
    txt { "tags:", "  - " },
    ins(2),
    newline(),
    txt { "---" },
    newline(2),
    ins(0),
  }),

  snip({ trig = "link", dscr = "Markdown hyperlink" }, {
    txt { "[" },
    ins(1),
    txt { "]" },
    txt { "(" },
    ins(2),
    txt { ")" },
  }),
}
