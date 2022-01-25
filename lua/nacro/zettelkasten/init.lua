local zk = {}

local neuron = require "neuron"
local n_telescope = require "neuron.telescope"
local n_cmd = require "neuron.cmd"

local builtin = require "telescope.builtin"

local keymap = vim.keymap

zk.dir = vim.env.HOME .. "/Zettels"

local function inserter(func)
  return function()
    func { insert = true }
  end
end

function zk.find_zettel_by_filename(zk_dir)
  zk_dir = zk_dir or zk.dir
  builtin.find_files { cwd = zk_dir }
end

function zk.new_zettel(name, zk_dir)
  zk_dir = zk_dir or zk.dir
  if not name then
    vim.ui.input({ prompt = "New zettel: " }, function(inp)
      name = inp
    end)
  end

  if not name then
    return
  end

  vim.cmd("edit " .. zk.dir .. "/" .. name)
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

  keymap.set("n", "<leader>ez", zk.find_zettel_by_filename)
  keymap.set("n", "<leader>zi", inserter(n_telescope.find_zettels))
  keymap.set("n", "<leader>zi", inserter(n_telescope.find_zettels))
end

return zk
