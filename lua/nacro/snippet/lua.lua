local luasnip = require "luasnip"
local common = require'nacro.snippet.common'

local snip = luasnip.s
local subsnip = luasnip.sn
local txt = luasnip.text_node
local ins = luasnip.insert_node
local choice = luasnip.choice_node
local dyn = luasnip.dynamic_node
local fn = luasnip.function_node

local copy = common.copy
local newline = common.newline
local indent = common.indent
local last_element_as_snip = common.last_element_as_snip

return {
    snip("fmt", {
      txt '("',
      ins(1),
      txt '"):format(',
      ins(2),
      txt ")",
    }),

    snip({ trig = "func", dscr = "Lua function", wordTrig = true }, {
      txt { "function " },
      ins(1, "name"),
      txt { "(" },
      ins(2),
      txt { ")" },
      newline(),
      indent(),
      ins(0),
      newline(),
      txt { "end" },
    }),

    snip({ trig = "mod", dscr = "Lua module table", wordTrig = true }, {
      txt  "local " ,
      dyn(1, function()
        local file_name = vim.fn.expand "%:t"
        local module_table_name
        if file_name == "init.lua" then
          local parent_path = vim.fn.expand "%:h"
          local path_elems = vim.split(parent_path, "/")
          -- first parent folder name
          module_table_name = path_elems[#path_elems]
        else
          -- file name without extension
          module_table_name = vim.split(file_name, "%.")[1]
        end
        return subsnip(nil, { ins(1, module_table_name) })
      end, {}),
      txt  " = {}" ,
      newline(2),
      ins(0),
      newline(2),
      txt  "return " ,
      copy(1),
    }),

    snip("ins", { txt { "print(vim.inspect(" }, ins(1), txt { "))" } }),

    snip(
      { trig = "r", dscr = "Require snippet", wordTrig = true },
      { txt { "require('" }, ins(1), txt { "')" } }
    ),

    snip({ trig = "lr", dscr = "Require module to local", wordTrig = true }, {
      txt { "local " },
      dyn(2, last_element_as_snip "%.", 1),
      txt { " = require('" },
      ins(1),
      txt { "')" },
    }),

    snip({ trig = "ll", dscr = "Require global to local", wordTrig = true }, {
      txt { "local " },
      dyn(2, last_element_as_snip "%.", 1),
      txt { " = " },
      ins(1),
    }),

    snip({ trig = "des", dscr = "`describe`-`it` block" }, {
      txt { "describe('" },
      ins(1),
      txt { "', function()" },
      newline(2),
      indent(),
      txt { "it('" },
      ins(2),
      txt { "', function()" },
      newline(),
      indent(2),
      ins(0),
      newline(),
      indent(),
      txt { "end)" },
      newline(2),
      txt { "end)" },
    }),
  }
