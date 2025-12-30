local saferequire = require("nacro.module").saferequire

local function config()
  require("workspaces").setup {
    hooks = {
      open = function()
        require("arrow.persist").load_cache_file()
      end,
    },
  }
  require("telescope").load_extension "workspaces"
end

local function pick()
  require("telescope").extensions.workspaces.workspaces { layout_strategy = "center" }
end

return {
  "natecraddock/workspaces.nvim",
  enabled = false,
  keys = {
    { "<leader>w", pick },
    {
      "<leader>W",
      function()
        require("workspaces").setup { global_cd = false }
        pick()
        require("workspaces").setup()
      end,
    },
  },
  cmd = {
    "WorkspacesAdd",
    "WorkspacesList",
    "WorkspacesOpen",
    "WorkspacesRemove",
    "WorkspacesRename",
  },
  config = config,
  dependencies = { "nvim-telescope/telescope.nvim" },
}
