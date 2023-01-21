local function config()
  local starlite = require "starlite"
  vim.keymap.set("n", "*", starlite.star)
  vim.keymap.set("n", "g*", starlite.g_star)
  vim.keymap.set("n", "#", starlite.hash)
  vim.keymap.set("n", "g#", starlite.g_hash)
end

return {
  "ironhouzi/starlite-nvim",
  keys = {
    {
      "*",
      function()
        require("starlite").star()
      end,
    },
    {
      "g*",
      function()
        require("starlite").g_star()
      end,
    },
    {
      "#",
      function()
        require("starlite").hash()
      end,
    },
    {
      "g#",
      function()
        require("starlite").g_hash()
      end,
    },
  },
}
