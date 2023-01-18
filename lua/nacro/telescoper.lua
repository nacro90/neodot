local telescoper = {}

local err_writeln = vim.api.nvim_err_writeln

local map = require "nacro.utils.map"
local nnoremap = map.nnoremap

local telescope = require "telescope"
local builtin = require "telescope.builtin"
local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local actions = require "telescope.actions"
local previewers = require "telescope.previewers"
local action_state = require "telescope.actions.state"
local conf = require("telescope.config").values

local function find(cwd, only_dir, hidden)
  if 1 ~= vim.fn.executable "fd" then
    err_writeln "fd not found in the system"
    return
  end

  local find_command = {
    "fd",
    "--no-ignore-vcs",
    "--exclude",
    "*.class",
    "--exclude",
    "target",
    "--exclude",
    "node_modules",
    hidden and "--hidden" or "",
    "--type",
    only_dir and "d" or "f",
    ".",
  }

  builtin.find_files {
    cwd = cwd or vim.loop.cwd(),
    find_command = find_command,
    -- previewer = false,
    layout_strategy = "flex",
    shorten_path = false,
  }
end

telescoper.find_files = find

function telescoper.find_dirs(cwd)
  find(cwd, true)
end

function telescoper.find_zettel(zettelkasten_dir)
  zettelkasten_dir = zettelkasten_dir or vim.env.HOME .. "/zettelkasten"
  builtin.find_files { cwd = zettelkasten_dir }
end

local function load_extensions()
  local exts = {
    "fzf",
    -- "dap",
    "zoxide",
    "ui-select",
    "http",
  }

  for _, ext in ipairs(exts) do
    telescope.load_extension(ext)
  end
end

local function set_keymaps()
  nnoremap("<leader>N", function()
    builtin.find_files { hidden = true, no_ignore = true }
  end)
  nnoremap("<leader>n", function()
    if vim.fn.getcwd() == vim.env.HOME then
      print "You are in $HOME"
      return
    end
    builtin.find_files()
  end)

  nnoremap("<leader>en", function()
    builtin.find_files { cwd = vim.fn.stdpath "config" }
  end)
  nnoremap("<leader>eN", function()
    builtin.find_files { cwd = vim.fn.stdpath "data" }
  end)
  nnoremap("<leader>o", function()
    builtin.live_grep { path_display = { "tail" } }
  end)
  nnoremap("<leader>O", function()
    builtin.live_grep {
      path_display = { "tail" },
      additional_args = function()
        return { "--hidden" }
      end,
    }
  end)

  local extensions = telescope.extensions
  vim.keymap.set("n", "<leader>/", builtin.current_buffer_fuzzy_find)
  vim.keymap.set("n", "<leader>:", builtin.command_history)
  vim.keymap.set("n", "<leader>b", builtin.buffers)
  vim.keymap.set("n", "<leader>H", builtin.oldfiles)
  vim.keymap.set("n", "<leader><C-h>", builtin.help_tags)
  vim.keymap.set("n", "<leader>c", extensions.zoxide.list)

  nnoremap("<leader>ep", function()
    telescoper.find_dirs(vim.env.HOME .. "/Projects", 2)
  end)
end

function telescoper.setup()
  telescope.setup {
    defaults = {
      layout_strategy = "flex",
      history = {
        path = "~/.local/share/nvim/telescope_history.sqlite3",
        limit = 100,
      },
    },
    extensions = {
      frecency = {
        show_scores = false,
        ignore_patterns = { "*.git/*" },
        workspaces = {
          ["conf"] = "/home/orcan/.config",
          ["data"] = "/home/orcan/.local/share",
          ["prod"] = "/home/orcan/prod",
        },
      },
      fzf = {
        fuzzy = true, -- false will only do exact matching
        override_generic_sorter = true, -- override the generic sorter
        override_file_sorter = true, -- override the file sorter
        case_mode = "smart_case", -- or "ignore_case" or "respect_case"
        -- the default case_mode is "smart_case"
      },
    },
    pickers = {
      find_files = {
        find_command = {
          "fd",
          "--type",
          "f",
          "--strip-cwd-prefix",
          "--exclude",
          "*.class",
          "--exclude",
          "target",
          "--exclude",
          "node_modules",
        },
      },
    },
  }

  load_extensions()
  set_keymaps()
end

return telescoper
