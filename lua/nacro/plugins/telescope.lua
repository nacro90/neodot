local function config()
  local telescope = require "telescope"
  telescope.setup {
    defaults = {
      layout_strategy = "flex",
      selection_strategy = "follow",
      path_display = { "smart" },
      history = {
        path = vim.fn.stdpath "data" .. "/telescope_history.sqlite3",
        limit = 100,
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
      mappings = {
        n = {
          ["<C-n>"] = require("telescope.actions").cycle_history_next,
          ["<C-p>"] = require("telescope.actions").cycle_history_prev,
        },
        i = {
          ["<C-g>"] = require("telescope.actions.layout").toggle_preview,
          ["<C-e>"] = require("telescope.actions").results_scrolling_down,
          ["<C-y>"] = require("telescope.actions").results_scrolling_up,
        },
      },
    },
    extensions = {
      dap = {
        list_breakpoints = {},
      },
    },
    pickers = {
      find_files = {
        find_command = { "fd", "--type", "f", "--strip-cwd-prefix" },
      },
      buffers = {
        sort_mru = true,
      },
      man_pages = {
        layout_strategy = "flex",
      },
      help_tags = {
        layout_strategy = "flex",
      },
      current_buffer_fuzzy_find = {
        previewer = false,
      },
      live_grep = {
        layout_strategy = "vertical",
      },
      lsp_dynamic_workspace_symbols = {
        layout_strategy = "vertical",
      },
      lsp_implementations = {
        layout_strategy = "vertical",
      },
      git_status = {
        initial_mode = "normal",
      },
      builtin = {
        include_extensions = true,
      },
    },
  }
  telescope.load_extension "fzf"
  telescope.load_extension "zoxide"
  telescope.load_extension "ui-select"
  telescope.load_extension "http"
end

local function find_files_with_home_guard(...)
  if vim.fn.getcwd() == vim.env.HOME then
    print "You are in $HOME"
    return
  end
  require("telescope.builtin").find_files(...)
end

local function builtiner(picker)
  return function()
    require("telescope.builtin")[picker]()
  end
end

local keys = {
  { "<leader>n", find_files_with_home_guard },
  {
    "<leader>N",
    function()
      find_files_with_home_guard { hidden = true, no_ignore = true }
    end,
  },
  {
    "<leader>en",
    function()
      require("telescope.builtin").find_files { cwd = vim.fn.stdpath "config" }
    end,
  },
  {
    "<leader>eN",
    function()
      require("telescope.builtin").find_files { cwd = vim.fn.stdpath "data" }
    end,
  },
  {
    "<leader>o",
    function()
      require("telescope.builtin").live_grep { path_display = { "tail" } }
    end,
  },
  {
    "<leader>O",
    function()
      require("telescope.builtin").live_grep {
        path_display = { "tail" },
        additional_args = { "--hidden" },
      }
    end,
  },
  { "<leader>/", builtiner "current_buffer_fuzzy_find" },
  { "<leader>:", builtiner "command_history" },
  { "<leader>?", builtiner "search_history" },
  { "<leader>B", builtiner "buffers" },
  {
    "<leader>b",
    function()
      require("telescope.builtin").buffers { only_cwd = true }
    end,
  },
  { "<leader>H", builtiner "oldfiles" },
  { "<leader><C-h>", builtiner "help_tags" },
  {
    "<leader>c",
    function()
      require("telescope").extensions.zoxide.list()
    end,
  },
  {
    "<leader>ep",
    function()
      require("telescope.builtin").find_files {
        cwd = vim.env.HOME .. "/Projects",
        find_command = { "fd", "--type", "d", "--max-depth", "1", "--strip-cwd-prefix" },
      }
    end,
  },
  {
    "<leader>j",
    function()
      require("telescope.builtin").diagnostics {
        layout_strategy = "vertical",
      }
    end,
  },
  { "<leader><leader>", builtiner "resume" },
  { "<leader>gs", builtiner "git_status" },
  { "<leader>gc", builtiner "git_bcommits" },
  { "<leader>gC", builtiner "git_commits" },
  { "<leader>gb", builtiner "git_branches" },
}

return {
  "nvim-lua/telescope.nvim",
  version = "1.1.x",
  keys = keys,
  cmd = "Telescope",
  config = config,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
    "jvgrootveld/telescope-zoxide",
    "barrett-ruth/telescope-http.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
    },
  },
}
