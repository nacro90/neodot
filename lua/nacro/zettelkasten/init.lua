local zk = {}

local builtin = require "telescope.builtin"

local keymap = vim.keymap

zk.dir = vim.env.HOME .. "/Zettels"

local function set_cd_autocmd()
  local group = vim.api.nvim_create_augroup("nacro_zettelkasten", {})
  vim.api.nvim_create_autocmd("WinEnter", {
    group = group,
    pattern = ("*%s/*"):format(zk.dir),
    command = "lcd %:h",
    desc = "In order to save images to parent static folder, sets lcd to parent folder",
  })
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
  keymap.set("n", "<leader>ez", zk.find_zettel_by_filename)
  set_cd_autocmd()
end

return zk
