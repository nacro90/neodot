local saferequire = require("nacro.module").saferequire

local function config()
  require("workspaces").setup()
  require("telescope").load_extension "workspaces"
end

local function pick()
  require("telescope").extensions.workspaces.workspaces { layout_strategy = "center" }
end

return {
  "natecraddock/workspaces.nvim",
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
  config = config,
  dependencies = { "nvim-lua/telescope.nvim" },
}
