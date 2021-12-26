local nacro_nvim_tree = {}

local ps = require "plenary.strings"

local map = require "nacro.utils.map"
local nvim_tree = require "nvim-tree"

local cmd = vim.cmd
local api = vim.api
local nnoremap = map.nnoremap

function nacro_nvim_tree.setup_events()
  cmd [[
    augroup nacro_nvim_tree
      autocmd!
      autocmd CursorMoved *NvimTree lua require('nacro.nvim_tree').on_cursor_moved()
    augroup END
  ]]
end

function nacro_nvim_tree.disable_events()
  cmd [[
    augroup nacro_nvim_tree
      autocmd!
    augroup END
    augroup! nacro_nvim_tree
  ]]
end

function nacro_nvim_tree.fit_width(bufnr, offset)
  assert(bufnr, "NvimTree buffer must be provided")
  offset = offset or 3
  local lines = api.nvim_buf_get_lines(bufnr, 1, -1, true)
  local max_display_width = vim.g.nvim_tree_width or require("nvim-tree.view").View.width
  for _, line in ipairs(lines) do
    max_display_width = math.max(ps.strdisplaywidth(line) + offset, max_display_width)
  end
  require("nvim-tree").resize(max_display_width)
end

function nacro_nvim_tree.on_cursor_moved()
  local bufnr = api.nvim_get_current_buf()
  nacro_nvim_tree.fit_width(bufnr)
end

function nacro_nvim_tree.setup()
  vim.g.nvim_tree_group_empty = 1
  vim.g.nvim_tree_show_icons = {
    git = 0,
    folders = 1,
    files = 1,
    folder_arrows = 0,
  }

  local tree_cb = require("nvim-tree.config").nvim_tree_callback

  require("nvim-tree").setup {
    update_cwd = true,
    view = {
      width = 30,
      auto_resize = true,
      mappings = {
        -- custom only false will merge the list with the default mappings
        -- if true, it will only use your list to set the mappings
        custom_only = false,
        -- list of mappings to set on the tree manually
        list = {
          { key = "h", cb = tree_cb "close_node" },
          { key = "l", cb = tree_cb "edit" },
          { key = "v", cb = tree_cb "vsplit" },
          { key = "s", cb = tree_cb "split" },
        },
      },
    },
  }

  nnoremap("<leader>f", nvim_tree.toggle)
  nnoremap("<leader>F", function()
    nvim_tree.find_file()
  end)

  nacro_nvim_tree.setup_events()
end

return nacro_nvim_tree
