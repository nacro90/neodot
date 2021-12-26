local n_project = {}

local telescope_exists, telescope = pcall(require, "telescope")

local project_nvim = require "project_nvim"

function n_project.setup()
  project_nvim.setup {
    detection_methods = { "pattern", "lsp" },
    patterns = {
      "=*.nvim",
      "!.golang",
    },
    ignore_lsp = { "null-ls", "sumneko_lua" },
  }

  if telescope_exists then
    telescope.load_extension "projects"
  end
end

return n_project
