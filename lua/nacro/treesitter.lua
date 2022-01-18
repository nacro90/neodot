local M = {}

local configs = require "nvim-treesitter.configs"

function M.setup()
  configs.setup {
    ensure_installed = "maintained",
    highlight = { enable = true, disable = { "markdown" } },
    textobjects = {
      select = {
        enable = true,
        keymaps = {
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["at"] = "@class.outer",
          ["it"] = "@class.inner",
          ["ig"] = "@block.inner",
          ["ag"] = "@block.outer",
          ["io"] = "@call.inner",
          ["ao"] = "@call.outer",
          ["ij"] = "@conditional.inner",
          ["aj"] = "@conditional.outer",
          ["il"] = "@loop.inner",
          ["al"] = "@loop.outer",
          ["ia"] = "@parameter.inner",
          ["aa"] = "@parameter.outer",
          ["as"] = "@statement.outer",
        },
      },
    },
    indent = { enable = false },
    autotag = { enable = true },
  }
end

return M
