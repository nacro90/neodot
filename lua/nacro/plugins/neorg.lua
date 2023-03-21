local function config()
  require("neorg").setup {
    load = {
      ["core.defaults"] = {},
      ["core.norg.concealer"] = {
        config = {
          icon_preset = "diamond",
          icons = {
            todo = {
              undone = {
                enabled = false,
              },
              uncertain = {
                enabled = false,
              },
            },
          },
        },
      },
      ["core.norg.dirman"] = {
        config = {
          default_workspace = "norgs",
          use_popup = false,
          workspaces = {
            norgs = "~/Norgs",
            trendyol = "~/Norgs/trendyol",
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
            keybinds.remap_event("all", "n", "<leader>Z", "core.norg.dirman.new.note")
            keybinds.map_event_to_mode("norg", {
              n = {
                { "]h", "core.integrations.treesitter.next.heading" },
                { "[h", "core.integrations.treesitter.previous.heading" },
              },
            }, {
              silent = true,
              noremap = true,
            })
            keybinds.map_to_mode("all", {
              n = {
                { "<leader>mn", "<Cmd>Neorg mode norg<CR>" },
                { "<leader>mh", "<Cmd>Neorg mode traverse-heading<CR>" },
              },
            }, {
              silent = true,
              noremap = true,
            })
            keybinds.map_event_to_mode("norg", {
              n = {
                { "<leader>l", "core.integrations.telescope.find_linkable" },
                { "<leader>s", "core.integrations.telescope.search_headings" },
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
  lazy = false,
  cmd = "Neorg",
  run = ":Neorg sync-parsers",
  config = config,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-neorg/neorg-telescope",
  },
}
