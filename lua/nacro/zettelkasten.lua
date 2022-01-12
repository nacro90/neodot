local zk = {}

local neuron = require "neuron"
local n_telescope = require "neuron.telescope"
local n_cmd = require "neuron.cmd"

local keymap = vim.keymap

zk.dir = vim.env.HOME .. "/Zettels"

local function inserter(func)
  return function()
    func { insert = true }
  end
end

function zk.setup()
  neuron.setup {
    neuron_dir = zk.dir,
    leader = "<leader>z",
  }

  local cmd_str = [[
    augroup nacro_neuron_setup
      autocmd!
      autocmd BufRead,BufNew %s/*.md lua require("neuron.mappings").set_keymaps()
    augroup END
  ]]
  vim.cmd(cmd_str:format(zk.dir))

  keymap.set("n", "<leader>zz", n_telescope.find_zettels)
  keymap.set("n", "<leader>zZ", inserter(n_telescope.find_zettels))
end

return zk
