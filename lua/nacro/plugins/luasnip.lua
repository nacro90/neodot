local snippet_fts = {
  "lua",
  "go",
  "telekasten",
  "dart",
  "markdown",
}

local function create_custom_snippets_table()
  local elements = {}
  for _, ft in ipairs(snippet_fts) do
    local exists, snips = pcall(require, "nacro.snippet." .. ft)
    if exists then
      elements[ft] = snips
    else
      vim.print("No snippet module found for", ft)
    end
  end
  return elements
end

local function config()
  local luasnip = require "luasnip"
  local snipmate_loader = require "luasnip.loaders.from_snipmate"

  local keymap = vim.keymap

  local function next_choice()
    return luasnip.change_choice(1)
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
    return luasnip.expand_or_locally_jumpable() and luasnip.expand_or_jump()
  end, { silent = true })
  keymap.set("i", "<C-j>", jump_back, { silent = true })
  keymap.set("s", "<C-k>", jump_forward, { silent = true })
  keymap.set("s", "<C-j>", jump_back, { silent = true })
  keymap.set("i", "<C-n>", next_choice, { silent = true })
  keymap.set("i", "<C-p>", prev_choice, { silent = true })

  for ft, snips in pairs(create_custom_snippets_table()) do
    luasnip.add_snippets(ft, snips)
  end

  snipmate_loader.lazy_load()
end

return {
  "L3MON4D3/LuaSnip",
  config = config,
  event = "InsertEnter",
}
