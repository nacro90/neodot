local function config()
  local telescope = require "telescope"
  local actions = require "telescope.actions"
  local layout = require "telescope.actions.layout"

  telescope.setup {
    defaults = {
      border = true,
      borderchars = { " ", " ", " ", " ", " ", " ", " ", " " },
      dynamic_preview_title = true,
      results_title = false,
      selection_caret = " ",
      entry_prefix = " ",
      prompt_prefix = " ",
      layout_strategy = "flex",
      selection_strategy = "reset",
      sorting_strategy = "descending",
      path_display = { truncate = 2 },

      file_ignore_patterns = {
        "node_modules",
        ".git/",
        ".dart_tool",
        ".angular",
        "__pycache__",
        ".venv",
        "%.lock",
      },

      vimgrep_arguments = {
        "rg",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
        "--trim",
      },

      cache_picker = {
        num_pickers = 10,
      },

      preview = {
        treesitter = true,
        filesize_limit = 1,
      },

      mappings = {
        n = {
          ["<C-n>"] = actions.cycle_history_next,
          ["<C-p>"] = actions.cycle_history_prev,
          ["q"] = actions.close,
          ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
        },
        i = {
          ["<C-g>"] = layout.toggle_preview,
          ["<C-e>"] = actions.results_scrolling_down,
          ["<C-y>"] = actions.results_scrolling_up,
          ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
          ["<C-s>"] = actions.select_horizontal,
        },
      },
    },

    pickers = {
      find_files = {
        find_command = {
          "fd",
          "--type", "f",
          "--strip-cwd-prefix",
          "--hidden",
          "--no-ignore-vcs",
          "--exclude", "node_modules",
          "--exclude", ".git",
          "--exclude", ".dart_tool",
          "--exclude", ".angular",
        },
      },
      buffers = {
        sort_mru = true,
        ignore_current_buffer = true,
      },
      man_pages = {
        layout_strategy = "flex",
      },
      help_tags = {
        layout_strategy = "flex",
      },
      current_buffer_fuzzy_find = {
        previewer = false,
        sorting_strategy = "ascending",
      },
      live_grep = {
        layout_strategy = "vertical",
      },
      git_status = {
        layout_strategy = "vertical",
      },
      git_commits = {
        layout_strategy = "vertical",
      },
      git_bcommits = {
        layout_strategy = "vertical",
      },
      lsp_dynamic_workspace_symbols = {
        layout_strategy = "vertical",
        fname_width = 80,
        symbol_width = 80,
      },
      lsp_document_symbols = {
        layout_strategy = "vertical",
        fname_width = 80,
        symbol_width = 80,
      },
      lsp_implementations = {
        layout_strategy = "vertical",
        fname_width = 100,
        show_line = true,
        file_ignore_patterns = { ".*mock.*" },
      },
      lsp_references = {
        layout_strategy = "vertical",
        fname_width = 100,
        show_line = true,
        include_declaration = false,
      },
      builtin = {
        include_extensions = true,
      },
    },

    extensions = {
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = "smart_case",
      },
      ["ui-select"] = {
        layout_strategy = "center",
      },
      zoxide = {
        prompt_title = "Zoxide",
        layout_strategy = "center",
      },
      dap = {
        list_breakpoints = {
          layout_strategy = "center",
        },
      },
      frecency = {
        show_scores = false,
        show_unindexed = true,
        ignore_patterns = { "*.git/*", "*/tmp/*", "*/node_modules/*" },
        workspaces = {
          ["nvim"] = vim.fn.stdpath "config",
        },
      },
      projects = {
        layout_strategy = "center",
      },
    },
  }

  -- Load extensions
  telescope.load_extension "fzf"
  telescope.load_extension "ui-select"
  telescope.load_extension "zoxide"
  telescope.load_extension "frecency"
  telescope.load_extension "projects"
end

local function find_files_with_home_guard(opts)
  if vim.fn.getcwd() == vim.env.HOME then
    vim.notify("You are in $HOME", vim.log.levels.WARN)
    return
  end
  require("telescope.builtin").find_files(opts)
end

local keys = {
  -- File finding
  {
    "<leader>n",
    function()
      find_files_with_home_guard()
    end,
    desc = "Find files",
  },
  {
    "<leader>N",
    function()
      find_files_with_home_guard { hidden = true, no_ignore = true }
    end,
    desc = "Find all files (hidden+ignored)",
  },

  -- Config files
  {
    "<leader>en",
    function()
      require("telescope.builtin").find_files { cwd = vim.fn.stdpath "config" }
    end,
    desc = "Find nvim config files",
  },
  {
    "<leader>eN",
    function()
      require("telescope.builtin").find_files { cwd = vim.fn.stdpath "data" }
    end,
    desc = "Find nvim data files",
  },
  {
    "<leader>ec",
    function()
      require("telescope.builtin").find_files { cwd = vim.env.XDG_CONFIG_HOME }
    end,
    desc = "Find XDG config files",
  },

  -- Grep
  {
    "<leader>o",
    function()
      require("telescope.builtin").live_grep()
    end,
    desc = "Live grep",
  },
  {
    "<leader>O",
    function()
      require("telescope.builtin").live_grep { additional_args = { "--hidden" } }
    end,
    desc = "Live grep (hidden)",
  },
  {
    "<leader>/",
    function()
      require("telescope.builtin").current_buffer_fuzzy_find()
    end,
    desc = "Fuzzy find in buffer",
  },

  -- History
  {
    "<leader>:",
    function()
      require("telescope.builtin").command_history { layout_strategy = "center" }
    end,
    desc = "Command history",
  },
  {
    "<leader>?",
    function()
      require("telescope.builtin").search_history { layout_strategy = "center" }
    end,
    desc = "Search history",
  },

  -- Buffers
  {
    "<leader>b",
    function()
      require("telescope.builtin").buffers()
    end,
    desc = "Buffers",
  },
  {
    "<leader>B",
    function()
      require("telescope.builtin").buffers { only_cwd = true }
    end,
    desc = "Buffers (cwd only)",
  },
  {
    "<leader>H",
    function()
      require("telescope").extensions.frecency.frecency()
    end,
    desc = "Frecent files",
  },
  {
    "<leader><C-H>",
    function()
      require("telescope").extensions.frecency.frecency { workspace = "CWD" }
    end,
    desc = "Frecent files (CWD)",
  },
  {
    "<leader><C-h>",
    function()
      require("telescope.builtin").help_tags()
    end,
    desc = "Help tags",
  },

  -- Diagnostics
  {
    "<leader>j",
    function()
      require("telescope.builtin").diagnostics {
        layout_strategy = "vertical",
        severity_limit = "WARN",
      }
    end,
    desc = "Diagnostics",
  },

  -- Resume
  {
    "<leader>k",
    function()
      require("telescope.builtin").resume()
    end,
    desc = "Resume last picker",
  },

  -- Git
  {
    "<leader>gs",
    function()
      require("telescope.builtin").git_status()
    end,
    desc = "Git status",
  },
  {
    "<leader>gc",
    function()
      require("telescope.builtin").git_bcommits()
    end,
    desc = "Git buffer commits",
  },
  {
    "<leader>gC",
    function()
      require("telescope.builtin").git_commits()
    end,
    desc = "Git commits",
  },
  {
    "<leader>gb",
    function()
      require("telescope.builtin").git_branches()
    end,
    desc = "Git branches",
  },

  -- LSP
  {
    "<leader>u",
    function()
      require("telescope.builtin").lsp_references()
    end,
    desc = "LSP references",
  },
  {
    "<leader>i",
    function()
      require("telescope.builtin").lsp_implementations()
    end,
    desc = "LSP implementations",
  },
  {
    "<leader>s",
    function()
      require("telescope.builtin").lsp_dynamic_workspace_symbols()
    end,
    desc = "LSP workspace symbols",
  },
  {
    "<leader>S",
    function()
      require("telescope.builtin").lsp_document_symbols()
    end,
    desc = "LSP document symbols",
  },

  -- Projects (auto-detected, all visited projects)
  {
    "<leader>W",
    function()
      require("telescope").extensions.projects.projects()
    end,
    desc = "Projects (auto)",
  },

  -- Zoxide (terminal directories)
  {
    "<leader><C-w>",
    function()
      require("telescope").extensions.zoxide.list()
    end,
    desc = "Zoxide directories",
  },
}

return {
  "nvim-telescope/telescope.nvim",
  keys = keys,
  cmd = "Telescope",
  config = config,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
    "jvgrootveld/telescope-zoxide",
    "ahmedkhalf/project.nvim",
    "natecraddock/workspaces.nvim",
    {
      "nvim-telescope/telescope-frecency.nvim",
      version = "*",
    },
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
    },
  },
}
