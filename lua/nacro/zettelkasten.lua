local zk = {}

local neuron = require "neuron"

local keymap = vim.keymap
local api = vim.api

zk.zettelkasten_dir = "~/Zettels"

function zk.setup()
  neuron.setup {
    neuron_dir = zk.zettelkasten_dir,
    mappings = false,
  }
end

return zk
