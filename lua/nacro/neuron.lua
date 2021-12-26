local nacro_neuron = {}

local neuron = require "neuron"

function nacro_neuron.setup()
  neuron.setup {
    virtual_titles = true,
    mappings = true,
    run = nil,
    neuron_dir = "~/zettelkasten",
    leader = "gz",
  }
end

return nacro_neuron
