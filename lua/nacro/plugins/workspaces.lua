local saferequire = require("nacro.module").saferequire

return {
  "natecraddock/workspaces.nvim",
  keys = {
    { "<leader>w" },
    { "<leader>W" },
  },
  config = function()
    local workspaces = require "workspaces"
    workspaces.setup()

    saferequire("telescope", function(telescope)
      telescope.load_extension "workspaces"
    end)

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
      workspaces.setup()
    end)
  end,
}
