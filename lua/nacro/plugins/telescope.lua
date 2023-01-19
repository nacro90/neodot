local function config()
  local telescope = require "telescope"
  telescope.setup {
    defaults = {
      layout_strategy = "vertical",
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
    },
    extensions = {
      pickers = {
        find_files = {
          hidden = true,
          no_ignore = true,
          no_ignore_parent = true,
          find_command = { "fd", "--type", "f", "--strip-cwd-prefix" },
        },
      },
    },
    mappings = {
      n = {
        ["<C-n>"] = require("telescope.actions").cycle_history_next,
        ["<C-p>"] = require("telescope.actions").cycle_history_prev,
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
  {
    "n",
    "<leader>/",
    function()
      require("telescope.builtin").current_buffer_fuzzy_find()
    end,
  },
  {
    "<leader>:",
    function()
      require("telescope.builtin").command_history()
    end,
  },
  {
    "<leader>b",
    function()
      require("telescope.builtin").buffers()
    end,
  },
  {
    "<leader>H",
    function()
      require("telescope.builtin").oldfiles()
    end,
  },
  {
    "<leader><C-h>",
    function()
      require("telescope.builtin").help_tags()
    end,
  },
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
        find_command = { "fd", "--type", "d", "--max-depth", "2", "--strip-cwd-prefix" },
      }
    end,
  },
}

return {
  "nvim-lua/telescope.nvim",
  version = "1.1.x",
  keys = keys,
  config = config,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
    "jvgrootveld/telescope-zoxide",
    "barrett-ruth/telescope-http.nvim",
    "nvim-telescope/telescope-smart-history.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
    },
  },
}
