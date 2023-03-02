local function config()
  require("neorg").setup {
    load = {
      ["core.defaults"] = {},
      ["core.norg.concealer"] = {},
      ["core.norg.dirman"] = {
        config = {
          workspaces = {
            norgs = "~/Norgs",
          },
        },
      },
      ["core.norg.completion"] = {
        config = {
          engine = "nvim-cmp",
        },
      },
      ["core.keybinds"] = {
        config = {
          hook = function(keybinds)
            keybinds.remap_event("norg", "n", "<leader>Z", "core.norg.dirman.new.note")
            keybinds.map_event_to_mode("norg", {
              n = {
                { "<leader>l", "core.integrations.telescope.find_linkable" },
              },
              i = {
                { "<C-l>", "core.integrations.telescope.insert_link" },
              },
            }, {
              silent = true,
              noremap = true,
            })
          end,
        },
      },
      ["core.integrations.telescope"] = {},
    },
  }
end

return {
  "nvim-neorg/neorg",
  run = ":Neorg sync-parsers",
  config = config,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-neorg/neorg-telescope",
  },
}
