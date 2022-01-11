local zk = {}

local neuron = require "neuron"
local n_telescope = require "neuron.telescope"
local n_cmd = require "neuron.cmd"

local keymap = vim.keymap

zk.dir = vim.env.HOME .. "/Zettels"

function zk.setup()
  neuron.setup {
    neuron_dir = zk.dir,
    mappings = false,
  }

  keymap.set("n", "<leader>z", n_telescope.find_zettels)
  keymap.set("n", "<leader>Z", function()
    n_cmd.new_edit(zk.dir)
  end)
end

return zk
