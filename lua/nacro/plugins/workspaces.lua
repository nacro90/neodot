local function config()
  require("workspaces").setup {
    -- Use global cd for auto-session compatibility
    -- (auto-session only listens to DirChanged with "global" pattern)
    cd_type = "global",

    -- Sort by most recently used
    mru_sort = true,

    -- Don't notify on add/remove (cleaner experience)
    notify_info = false,

    hooks = {
      open = function()
        -- Reload Arrow bookmarks for the new workspace
        local ok, arrow = pcall(require, "arrow.persist")
        if ok then
          arrow.load_cache_file()
        end
      end,
    },
  }
  require("telescope").load_extension "workspaces"
end

local function delete_workspace(prompt_bufnr)
  local action_state = require "telescope.actions.state"
  local actions = require "telescope.actions"
  local workspaces = require "workspaces"

  local selected = action_state.get_selected_entry()
  if not selected then
    return
  end

  local workspace = selected.value
  local confirmed = vim.fn.confirm(
    string.format("Delete workspace '%s'?", workspace.name),
    "&Yes\n&No",
    2
  )

  if confirmed == 1 then
    actions.close(prompt_bufnr)
    workspaces.remove(workspace.name)
    vim.schedule(function()
      require("telescope").extensions.workspaces.workspaces { layout_strategy = "center" }
    end)
  end
end

local function pick()
  require("telescope").extensions.workspaces.workspaces {
    layout_strategy = "center",
    attach_mappings = function(_, map)
      map({ "i", "n" }, "<C-x>", delete_workspace)
      return true
    end,
  }
end

return {
  "natecraddock/workspaces.nvim",
  keys = {
    { "<leader>w", pick, desc = "Workspaces" },
  },
  cmd = {
    "WorkspacesAdd",
    "WorkspacesAddDir",
    "WorkspacesList",
    "WorkspacesOpen",
    "WorkspacesRemove",
    "WorkspacesRename",
    "WorkspacesSyncDirs",
  },
  config = config,
  dependencies = { "nvim-telescope/telescope.nvim" },
}
