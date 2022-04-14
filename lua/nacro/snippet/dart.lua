local luasnip = require "luasnip"
local fmt = require("luasnip.extras.fmt").fmt
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
  snip("stful", {
    txt { "class " },
    ins(1),
    txt { " extends StatefulWidget {" },
    newline(),
    indent(),
    txt { "const " },
    copy(1),
    txt { "({Key? key}) : super(key: key);" },
    newline(2),
    indent(),
    txt { "@override" },
    newline(),
    indent(),
    txt { "State<" },
    copy(1),
    txt { "> createState() => _" },
    copy(1),
    txt { "State();", "}" },
    newline(2),
    txt { "class _" },
    copy(1),
    txt { "State extends State<" },
    copy(1),
    txt { "> {" },
    newline(),
    indent(),
    txt { "@override" },
    newline(),
    indent(),
    txt { "Widget build(BuildContext context) {" },
    newline(),
    indent(2),
    txt { "return " },
    ins(2, "Container"),
    txt { "(" },
    ins(0),
    txt { ");" },
    newline(),
    indent(1),
    txt { "}" },
    newline(),
    txt { "}" },
  }),
  snip("dp", { txt { "debugPrint(" }, ins(0), txt { ");" } }),
}
--[[
class  StatefulWidget {  const ({Key? key}) : super(key: key);
@override
State<> createState() => _State();
}

class _State extends State<> {
@override
Widget build(BuildContext context) {
}
]]
