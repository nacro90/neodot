local notetaking = {}

local keymap = vim.keymap
local api = vim.api

function notetaking.setup()
  require("neuron").setup {
    neuron_dir = "~/Zettels",
  }
end

return notetaking
