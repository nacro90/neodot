return {
  "ahmedkhalf/project.nvim",
  event = "VeryLazy",
  config = function()
    require("project_nvim").setup {
      -- Detection methods: LSP first, then patterns
      detection_methods = { "lsp", "pattern" },

      -- Project root patterns (most common first)
      patterns = {
        ".git",
        "go.mod",
        "Cargo.toml",
        "package.json",
        "pubspec.yaml", -- Flutter/Dart
        "pyproject.toml",
        "setup.py",
        "Makefile",
        "CMakeLists.txt",
        ".nvim", -- Custom nvim project marker
      },

      -- Don't ignore any LSP servers
      ignore_lsp = {},

      -- Directories to exclude from project detection
      exclude_dirs = {
        "~",
        "~/Projects",
        "~/Downloads",
        "/tmp",
      },

      -- Show hidden files in telescope
      show_hidden = false,

      -- Don't notify on directory change (cleaner experience)
      silent_chdir = true,

      -- Use global scope for auto-session compatibility
      -- (auto-session only listens to DirChanged with "global" pattern)
      scope_chdir = "global",

      -- Store project history in nvim data directory
      datapath = vim.fn.stdpath "data",
    }
  end,
}
