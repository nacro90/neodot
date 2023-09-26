---@diagnostic disable-next-line: unused-local, unused-function
local function norg_search_dirs()
  local ok, neorg = pcall(require, "neorg")
  if not ok then
    return
  end
  local dirman = neorg.configuration.modules["core.norg.dirman"]
  if not dirman then
    return
  end
  local dirs = {}
  for _, dir in pairs(dirman.workspaces) do
    dirs[#dirs + 1] = vim.fn.expand(dir)
  end
  return dirs
end

local function config()
  local telescope = require "telescope"
  local actions = require "telescope.actions"
  local layout = require "telescope.actions.layout"
  telescope.setup {
    defaults = {
      layout_strategy = "flex",
      selection_strategy = "reset",
      path_display = { truncate = 2 },
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
          ["<C-n>"] = actions.cycle_history_next,
          ["<C-p>"] = actions.cycle_history_prev,
        },
        i = {
          ["<C-g>"] = layout.toggle_preview,
          ["<C-e>"] = actions.results_scrolling_down,
          ["<C-y>"] = actions.results_scrolling_up,
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
  telescope.load_extension "ui-select"
end

local function find_files_with_home_guard(...)
  if vim.fn.getcwd() == vim.env.HOME then
    vim.notify "You are in $HOME"
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
    "<leader>z",
    function()
      require("telescope.builtin").find_files {
        find_command = { "fd", "--type", "f", "--extension", "md", "--strip-cwd-prefix" },
        cwd = vim.env.HOME .. "/Zettels",
      }
    end,
  },
  { "<leader>o", builtiner "live_grep" },
  {
    "<leader>O",
    function()
      require("telescope.builtin").live_grep {
        additional_args = { "--hidden" },
      }
    end,
  },
  { "<leader>/", builtiner "current_buffer_fuzzy_find" },
  {
    "<leader>:",
    function()
      require("telescope.builtin").command_history { layout_strategy = "center" }
    end,
  },
  {
    "<leader>?",
    function()
      require("telescope.builtin").search_history { layout_strategy = "center" }
    end,
  },
  { "<leader>B", builtiner "buffers" },
  {
    "<leader>b",
    function()
      require("telescope.builtin").buffers { only_cwd = true }
    end,
  },
  { "<leader>H",     builtiner "oldfiles" },
  { "<leader><C-h>", builtiner "help_tags" },
  {
    "<leader>j",
    function()
      require("telescope.builtin").diagnostics { layout_strategy = "vertical" }
    end,
  },
  { "<leader><leader>", builtiner "resume" },
  { "<leader>gs",       builtiner "git_status" },
  { "<leader>gc",       builtiner "git_bcommits" },
  { "<leader>gC",       builtiner "git_commits" },
  { "<leader>gb",       builtiner "git_branches" },
}

return {
  "nvim-telescope/telescope.nvim",
  version = "1.1.x",
  keys = keys,
  cmd = "Telescope",
  config = config,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      enabled = true,
      build = "make",
    },
  },
}
