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

local function config()
  local luasnip = require "luasnip"
  local snipmate_loader = require "luasnip.loaders.from_snipmate"

  local keymap = vim.keymap

  local function next_choice()
    return luasnip.choice_active() and luasnip.change_choice(1)
  end

  local function prev_choice()
    return luasnip.choice_active() and luasnip.change_choice(-1)
  end

  local function jump_forward()
    luasnip.jump(1)
  end

  local function jump_back()
    luasnip.jump(-1)
  end

  keymap.set("i", "<C-k>", function()
    local ls = require'luasnip'
    if ls.expand_or_locally_jumpable() then
      ls.expand_or_jump()
      return
    end
    -- TODO: Trigger default <C-k>
  end, { silent = true })
  keymap.set("i", "<C-j>", jump_back, { silent = true })
  keymap.set("s", "<C-k>", jump_forward, { silent = true })
  keymap.set("s", "<C-j>", jump_back, { silent = true })
  keymap.set("s", "<C-n>", next_choice, { silent = true })
  keymap.set("s", "<C-p>", prev_choice, { silent = true })

  local ft_snippets = create_custom_snippets_table()

  for ft, snips in pairs(ft_snippets) do
    luasnip.add_snippets(ft, snips)
  end

  snipmate_loader.lazy_load()
end

return {
  "L3MON4D3/LuaSnip",
  config = config,
  event = "InsertEnter",
}
