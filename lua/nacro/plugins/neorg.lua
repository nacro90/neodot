local function extend_metagen_template(template, extend)
  local new_template = vim.deepcopy(template)
  for i, t in ipairs(new_template) do
    local k = t[1]
    if extend[k] then
      new_template[i] = { k, extend[k] }
      extend[k] = nil
    end
  end
  for k, v in pairs(extend) do
    new_template[#new_template + 1] = { k, v }
  end
  return new_template
end

local function remove_keys_metagen_template(template, keys)
  local new_template = vim.deepcopy(template)
  for i, t in ipairs(new_template) do
    local k = t[1]
    if vim.tbl_contains(keys, k) then
      table.remove(new_template, i)
    end
  end
  return new_template
end

---@diagnostic disable-next-line: unused-function, unused-local
local function create_metagen_template()
  local metagen = require "neorg.modules.core.esupports.metagen.module"
  local default_template = metagen.config.public.template
  local removed = remove_keys_metagen_template(default_template, { "categories", "description" })
  return extend_metagen_template(removed, {
    id = function()
      return os.date "%y%m%d%H%M%S"
    end,
  })
end

local function config()
  require("neorg").setup {
    load = {
      ["core.defaults"] = {},
      ["core.concealer"] = {
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
      ["core.dirman"] = {
        config = {
          default_workspace = "norgs",
          use_popup = false,
          workspaces = {
            norgs = "~/Norgs",
            trendyol = "~/Norgs/trendyol",
          },
        },
      },
      ["core.completion"] = {
        config = {
          engine = "nvim-cmp",
        },
      },
      ["core.journal"] = {
        config = {
          workspace = "norgs",
        },
      },
      -- ["core.esupports.metagen"] = {
      --   config = {
      --     type = "auto",
      --     template = create_metagen_template(),
      --   },
      -- },
      ["core.keybinds"] = {
        config = {
          hook = function(keybinds)
            keybinds.remap_event("all", "n", "<leader>Z", "core.dirman.new.note")
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
      ["external.zettelkasten"] = {},
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
    "max397574/neorg-zettelkasten",
  },
}
