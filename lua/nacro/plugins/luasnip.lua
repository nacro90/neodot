local snippet_fts = {
  "lua",
  "go",
  "telekasten",
  "dart",
  "markdown",
  "todo",
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
  for ft, snips in pairs(create_custom_snippets_table()) do
    require("luasnip").add_snippets(ft, snips)
  end
  require("luasnip.loaders.from_snipmate").lazy_load()
end

return {
  "L3MON4D3/LuaSnip",
  config = config,
  event = "InsertEnter",
}
