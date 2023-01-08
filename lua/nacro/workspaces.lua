local M = {}

local saferequire = require("nacro.module").saferequire

local default_opts = {}

function M.setup()
  saferequire("workspaces", function(workspaces)
    workspaces.setup(default_opts)

    local function pick()
      local picker
      local ok, telescope = pcall(require, "telescope")
      if ok and telescope.extensions.workspaces then
        picker = telescope.extensions.workspaces.workspaces
      else
        picker = workspaces.open
      end
      picker()
    end

    vim.keymap.set("n", "<leader>w", pick)
    vim.keymap.set("n", "<leader>W", function()
      workspaces.setup { global_cd = false }
      pick()
      workspaces.setup(default_opts)
    end)
  end)
end

return M
