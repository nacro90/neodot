local function is_nvim_tree_focused()
  local api = require "nvim-tree.api"
  return api.tree.is_tree_buf()
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

  -- Navigation
  vim.keymap.set("n", "h", api.node.navigate.parent_close, opts "Close parent")
  vim.keymap.set("n", "l", api.node.open.edit, opts "Open")
  vim.keymap.set("n", "+", api.tree.change_root_to_node, opts "CD into node")
  vim.keymap.set("n", "-", api.tree.change_root_to_parent, opts "CD to parent")

  -- Open variants
  vim.keymap.set("n", "O", api.node.run.system, opts "Open with system")
  vim.keymap.set("n", "t", api.node.open.tab, opts "Open in tab")
  vim.keymap.set("n", "v", api.node.open.vertical, opts "Open vertical")
  vim.keymap.set("n", "s", api.node.open.horizontal, opts "Open horizontal")

  -- Filters
  vim.keymap.set("n", "H", api.tree.toggle_hidden_filter, opts "Toggle hidden")
  vim.keymap.set("n", "I", api.tree.toggle_gitignore_filter, opts "Toggle gitignore")
  vim.keymap.set("n", "B", api.tree.toggle_no_buffer_filter, opts "Toggle no buffer")

  -- Live filter
  vim.keymap.set("n", "f", api.live_filter.start, opts "Live filter")
  vim.keymap.set("n", "F", api.live_filter.clear, opts "Clear filter")

  -- Bookmarks
  vim.keymap.set("n", "m", api.marks.toggle, opts "Toggle mark")
  vim.keymap.set("n", "bd", api.marks.bulk.delete, opts "Delete marked")
  vim.keymap.set("n", "bm", api.marks.bulk.move, opts "Move marked")
end

local opts = {
  on_attach = on_attach,

  sync_root_with_cwd = true,
  reload_on_bufenter = true,
  respect_buf_cwd = true,
  hijack_cursor = true,

  view = {
    width = {
      min = 30,
      max = 40,
      padding = 1,
    },
  },

  modified = {
    enable = true,
    show_on_dirs = true,
    show_on_open_dirs = true,
  },

  filesystem_watchers = {
    enable = true,
    debounce_delay = 50,
    ignore_dirs = {
      "node_modules",
      ".git",
      ".dart_tool",
      ".angular",
      "__pycache__",
      ".venv",
    },
  },

  filters = {
    dotfiles = false,
    git_ignored = false,
    custom = {},
    exclude = {},
  },

  actions = {
    open_file = {
      quit_on_open = false,
      resize_window = true,
      window_picker = {
        enable = true,
        chars = "ASDFGHJKL",
      },
    },
    remove_file = {
      close_window = true,
    },
    change_dir = {
      enable = true,
      global = false,
    },
  },

  ui = {
    confirm = {
      remove = true,
      trash = true,
      default_yes = false,
    },
  },

  live_filter = {
    prefix = "[FILTER]: ",
    always_show_folders = false,
  },

  tab = {
    sync = {
      open = true,
      close = true,
    },
  },

  notify = {
    threshold = vim.log.levels.WARN,
    absolute_path = false,
  },

  diagnostics = {
    enable = true,
    show_on_dirs = false,
    show_on_open_dirs = false,
    severity = {
      min = vim.diagnostic.severity.WARN,
    },
    icons = {
      hint = "▸",
      info = "›",
      warning = "▴",
      error = "▪",
    },
  },

  renderer = {
    group_empty = true,
    highlight_git = "none",
    highlight_modified = "icon",
    indent_markers = {
      enable = true,
    },
    icons = {
      show = {
        file = true,
        folder = true,
        folder_arrow = false,
        git = false,
        modified = true,
        diagnostics = true,
        bookmarks = true,
      },
      glyphs = {
        default = "",
        bookmark = "⋄",
        modified = "+",
        folder = {
          default = "▪",
          open = "-",
          empty = "▫",
          empty_open = "-",
          symlink = "▸",
          symlink_open = "▾",
        },
      },
    },
    special_files = {
      "Cargo.toml",
      "Makefile",
      "README.md",
      "readme.md",
      "justfile",
      "go.mod",
      "package.json",
      "pyproject.toml",
    },
  },
}

local keys = {
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
    desc = "Toggle file tree",
  },
  {
    "<leader>F",
    function()
      local api = require "nvim-tree.api"
      if not api.tree.is_visible() then
        api.tree.open { find_file = true }
      else
        api.tree.find_file { focus = true }
      end
    end,
    desc = "Find file in tree",
  },
  {
    "]m",
    function()
      require("nvim-tree.api").marks.navigate.next()
    end,
    desc = "Next tree mark",
  },
  {
    "[m",
    function()
      require("nvim-tree.api").marks.navigate.prev()
    end,
    desc = "Prev tree mark",
  },
  {
    "<leader>M",
    function()
      require("nvim-tree.api").marks.toggle()
    end,
    desc = "Toggle tree mark",
  },
  {
    "<leader><C-m>",
    function()
      pcall(require, "telescope")
      require("nvim-tree.api").marks.navigate.list()
    end,
    desc = "List tree marks",
  },
}

return {
  "nvim-tree/nvim-tree.lua",
  opts = opts,
  keys = keys,
  dependencies = { "nvim-tree/nvim-web-devicons" },
}
