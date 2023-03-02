local function config()
  -- local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()
  --
  -- parser_configs.norg = {
  --   install_info = {
  --     url = "https://github.com/nvim-neorg/tree-sitter-norg",
  --     files = { "src/parser.c", "src/scanner.cc" },
  --     branch = "main",
  --   },
  -- }

  local neorg = require "neorg"
  neorg.setup {
    load = {
      ["core.defaults"] = {},
      ["core.norg.concealer"] = {},
      ["core.norg.dirman"] = {
        config = {
          workspaces = {
            my_workspace = "~/Norgs",
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

return {
  "nvim-neorg/neorg",
  run = ":Neorg sync-parsers",
  config = config,
  dependencies = { "nvim-lua/plenary.nvim" },
}
