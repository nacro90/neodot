local M = {}

local luasnip = require "luasnip"
local vscode_loader = require "luasnip.loaders.from_vscode"

local keymap = vim.keymap

local function jump_forward()
  luasnip.jump(1)
end
local function jump_back()
  luasnip.jump(-1)
end

local snippet_fts = {
  "lua",
  "go",
  "telekasten",
  "dart",
}

local function create_custom_snippets_table()
  local elements = {}
  for _, ft in ipairs(snippet_fts) do
    local exists, snips = pcall(require, "nacro.snippet." .. ft)
    if exists then
      elements[ft] = snips
    else
      print("No snippet module found for", ft)
    end
  end
  return elements
end

local function next_choice()
  return luasnip.choice_active() and luasnip.change_choice(1)
end

local function prev_choice()
  return luasnip.choice_active() and luasnip.change_choice(-1)
end

function M.setup()
  keymap.set("i", "<C-k>", luasnip.expand_or_jump, { silent = true })
  keymap.set("i", "<C-j>", jump_back, { silent = true })
  keymap.set("s", "<C-k>", jump_forward, { silent = true })
  keymap.set("s", "<C-j>", jump_back, { silent = true })
  keymap.set("s", "<C-n>", next_choice, { silent = true })
  keymap.set("s", "<C-p>", prev_choice, { silent = true })

  local ft_snippets = create_custom_snippets_table()

  for ft, snips in pairs(ft_snippets) do
    luasnip.add_snippets(ft, snips)
  end

  vscode_loader.lazy_load()
end

return M
