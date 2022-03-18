local zk = {}

local builtin = require "telescope.builtin"

local keymap = vim.keymap

zk.dir = vim.env.HOME .. "/Zettels"

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
  keymap.set("n", "<leader>ez", zk.find_zettel_by_filename)
end

return zk
