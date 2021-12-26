local M = {}

local neorg = require "neorg"

function M.setup()
  -- local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()
  --
  -- parser_configs.norg = {
  --   install_info = {
  --     url = "https://github.com/nvim-neorg/tree-sitter-norg",
  --     files = { "src/parser.c", "src/scanner.cc" },
  --     branch = "main",
  --   },
  -- }

  neorg.setup {
    load = {
      ["core.defaults"] = {},
      ["core.norg.concealer"] = {},
      ["core.norg.dirman"] = {
        config = {
          workspaces = {
            my_workspace = "~/neorg",
          },
        },
      },
      ["core.norg.completion"] = {
        config = {
          engine = "nvim-cmp",
        },
      },
    },
  }
end

return M
