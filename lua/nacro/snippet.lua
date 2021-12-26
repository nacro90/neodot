local luasnip = require "luasnip"

local vim = vim
local opt = vim.opt

local snip = luasnip.s
---@diagnostic disable-next-line: unused-local
local subsnip = luasnip.sn
local txt = luasnip.text_node
local ins = luasnip.insert_node
-- local fn = luasnip.function_node
---@diagnostic disable-next-line: unused-local
local choice = luasnip.choice_node
---@diagnostic disable-next-line: unused-local
local dyn = luasnip.dynamic_node

--- Removes the necessity of the index argument
local function fn(func, index, ...)
  return luasnip.function_node(func, index or {}, ...)
end

--- Copies the insert node value with given index
local function copy(i)
  return fn(function(args)
    return args[1][1]
  end, i)
end

--- More verbose new line expression
local function newline(n)
  n = n or 1
  local lines = { "" }
  for _ = 1, n do
    lines[#lines + 1] = ""
  end
  return txt(lines)
end

local function indent(n)
  n = n or 1
  local rep = string.rep
  local function indenter()
    local expandtab = opt.expandtab:get()
    local tab_unit = expandtab and rep(" ", opt.shiftwidth:get()) or "\t"
    return rep(tab_unit, n)
  end
  return fn(indenter)
end

local function last_element_as_snip(separator_pattern)
  return function(args)
    local module_name = args[1][1]
    local nodes = vim.split(module_name, separator_pattern)
    return subsnip(nil, { ins(1, nodes[#nodes]) })
  end
end

return {
  all = {},

  lua = {
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
      txt { "local " },
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
      txt { " = {}" },
      newline(2),
      ins(0),
      newline(2),
      txt { "return " },
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
  },

  rust = {
    luasnip.parser.parse_snippet({ trig = "fn" }, "/// $1\nfn $2($3) ${4:-> $5 }\\{\n\t$0\n\\}"),
  },

  java = {
    snip(".var", { fn(function(args)
      print(vim.inspect(args))
    end) }),
  },

  go = {
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
  },

  markdown = {
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
  },
}
