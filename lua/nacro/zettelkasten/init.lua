local zk = {}

local builtin = require "telescope.builtin"
local telekasten = require "telekasten"

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

local function setup_telekasten()
  telekasten.setup {
    home = zk.dir,
    dailies = zk.dir .. "/daily",
    weeklies = zk.dir .. "/weekly",
    templates = zk.dir .. "/templates",
    image_subdir = "static",
    follow_creates_nonexisting = false,
    dailies_create_nonexisting = false,
    weeklies_create_nonexisting = false,
    image_link_style = "wiki",
    sort = "modified",
    tag_notation = "yaml-bare",
  }
end

local function setup_keymaps()
  keymap.set("n", "<leader>ez", telekasten.find_notes)
  keymap.set("n", "<leader>eZ", telekasten.new_note)
  keymap.set("n", "<leader>mt", telekasten.toggle_todo)
end

function zk.setup()
  -- set_cd_autocmd()
  setup_telekasten()
  setup_keymaps()
end

return zk
