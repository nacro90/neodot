local function is_nvim_tree_focused()
  local bufname = vim.api.nvim_buf_get_name(0)
  return not not bufname:find "NvimTree"
end

local function on_attach(bufnr)
  local function opts(desc)
    return {
      desc = "nvim-tree: " .. desc,
      buffer = bufnr,
      noremap = true,
      silent = true,
      nowait = true,
    }
  end

  local api = require "nvim-tree.api"
  api.config.mappings.default_on_attach(bufnr)

  vim.keymap.set("n", "h", api.node.navigate.parent_close, opts "Parent close")
  vim.keymap.set("n", "l", api.node.open.edit, opts "Edit")
  vim.keymap.set("n", "+", api.tree.change_root_to_node, opts "Change root to node")
  vim.keymap.set("n", "O", api.node.run.system, opts "Open file in OS")
  vim.keymap.set("n", "t", api.node.open.tab, opts "Open file in a tab")
  vim.keymap.set("n", "v", api.node.open.vertical, opts "Vertically open file")
  vim.keymap.set("n", "s", api.node.open.horizontal, opts "Horizontally open file")
end

return {
  "kyazdani42/nvim-tree.lua",
  opts = {
    on_attach = on_attach,
    sync_root_with_cwd = true,
    reload_on_bufenter = true,
    respect_buf_cwd = true,
    hijack_cursor = true,
    modified = {
      enable = true,
    },
    diagnostics = {
      enable = true,
      icons = {
        hint = "▸",
        info = "›",
        warning = "▴",
        error = "▪",
      },
      severity = {
        min = vim.diagnostic.severity.WARN,
      },
      show_on_dirs = false,
    },
    renderer = {
      group_empty = true,
      highlight_git = true,
      highlight_modified = "none",
      indent_markers = {
        enable = true,
      },
      icons = {
        show = {
          file = true,
          folder = true,
          folder_arrow = false,
          git = false,
        },
        glyphs = {
          bookmark = "⋄",
          modified = "+",
          default = "",
          folder = {
            default = "▪",
            open = "-",
            empty = "▫",
            empty_open = "-",
            symlink = "▸",
            symlink_open = "▼",
          },
          git = {
            unstaged = "✗",
            staged = "✓",
            unmerged = "",
            renamed = "➜",
            untracked = "?",
            deleted = "∅",
            ignored = "◌",
          },
        },
      },
      special_files = {
        "Cargo.toml",
        "Makefile",
        "README.md",
        "readme.md",
        "justfile",
      },
    },
  },
  keys = {
    {
      "<leader>f",
      function()
        local api = require "nvim-tree.api"
        if is_nvim_tree_focused() then
          api.tree.toggle()
          return
        end
        api.tree.focus()
      end,
    },
    {
      "<leader>F",
      function()
        require("nvim-tree.api").tree.find_file()
      end,
    },
    {
      "]m",
      function()
        require("nvim-tree.api").marks.navigate.next()
      end,
    },
    {
      "[m",
      function()
        require("nvim-tree.api").marks.navigate.prev()
      end,
    },
    {
      "<leader>M",
      function()
        require("nvim-tree.api").marks.toggle()
      end,
    },
    {
      "<leader><C-m>",
      function()
        pcall(require, "telescope")
        require("nvim-tree.api").marks.navigate.list()
      end,
    },
  },
  dependencies = { "nvim-tree/nvim-web-devicons" },
}
