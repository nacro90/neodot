local function config()
  require("nvim-tree").setup {
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
      show_on_dirs = true,
    },
    view = {
      adaptive_size = true,
      mappings = {
        list = {
          { key = "h", action = "close_node" },
          { key = "l", action = "edit" },
          { key = "v", action = "vsplit" },
          { key = "s", action = "split" },
          { key = "t", action = "tabnew" },
          { key = "+", action = "cd" },
          { key = "O", action = "system_open" },
          { key = "r", action = "raname_basename" },
          { key = "R", action = "full_raname" },
          { key = "<C-r>", action = "refresh" },
          { key = "]d", action = "next_diag_item" },
          { key = "[d", action = "prev_diag_item" },
          { key = "]h", action = "next_git_item" },
          { key = "[h", action = "prev_git_item" },
        },
      },
    },
    renderer = {
      group_empty = true,
      highlight_git = true,
      highlight_modified = "none",
      icons = {
        show = {
          file = true,
          folder = true,
          folder_arrow = false,
          git = true,
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
  }
end

return {
  "kyazdani42/nvim-tree.lua",
  config = config,
  keys = {
    {
      "<leader>f",
      function()
        require("nvim-tree").focus()
      end,
    },
    {
      "<leader>F",
      function()
        require("nvim-tree").find_file()
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
  dependencies = { "kyazdani42/nvim-web-devicons" },
}
