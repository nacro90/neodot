local ps = require "plenary.strings"

local cmd = vim.cmd
local api = vim.api

local function setup_events()
  cmd [[
    augroup nacro_nvim_tree
      autocmd!
      autocmd CursorMoved *NvimTree lua require('nacro.nvim_tree').on_cursor_moved()
    augroup END
  ]]
end

local function disable_events()
  cmd [[
    augroup nacro_nvim_tree
      autocmd!
    augroup END
    augroup! nacro_nvim_tree
  ]]
end

local function fit_width(bufnr, offset)
  assert(bufnr, "NvimTree buffer must be provided")
  offset = offset or 3
  local lines = api.nvim_buf_get_lines(bufnr, 1, -1, true)
  local max_display_width = vim.g.nvim_tree_width or require("nvim-tree.view").View.width
  for _, line in ipairs(lines) do
    max_display_width = math.max(ps.strdisplaywidth(line) + offset, max_display_width)
  end
  require("nvim-tree").resize(max_display_width)
end

local function on_cursor_moved()
  local bufnr = api.nvim_get_current_buf()
  print "kemal"
  nacro_nvim_tree.fit_width(bufnr)
end

local function config()
  local nvim_tree = require "nvim-tree"
  local tree_cb = require("nvim-tree.config").nvim_tree_callback

  require("nvim-tree").setup {
    update_cwd = true,
    view = {
      width = 30,
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
    renderer = {
      group_empty = true,
      icons = {
        show = {
          file = true,
          folder = true,
          folder_arrow = false,
          git = false,
        },
        glyphs = {
          folder = {
            arrow_open = "",
            arrow_closed = "",
            default = "▪",
            open = "-",
            empty = "▫",
            empty_open = "-",
            symlink = "▸",
            symlink_open = "▼",
          },
        },
      },
    },
  }

  vim.keymap.set("n", "<leader>f", nvim_tree.toggle)
  vim.keymap.set("n", "<leader>F", nvim_tree.find_file)

  -- nacro_nvim_tree.setup_events()
end

return {
  "kyazdani42/nvim-tree.lua",
  config = config,
  keys = {
    { "<leader>f" },
    { "<leader>F" },
  },
  dependencies = { "kyazdani42/nvim-web-devicons" },
}
