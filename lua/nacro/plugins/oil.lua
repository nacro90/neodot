-- oil.nvim - Edit filesystem like a buffer
-- Replaces netrw as default file explorer

return {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  lazy = false, -- Load immediately to hijack netrw
  keys = {
    { "-", "<cmd>Oil<cr>", desc = "Open parent directory" },
    { "<leader>-", "<cmd>Oil .<cr>", desc = "Open cwd in Oil" },
  },
  opts = {
    -- Netrw-style behavior: open directories with Oil
    default_file_explorer = true,

    -- Buffer-local options for oil buffers
    buf_options = {
      buflisted = false,
      bufhidden = "hide",
    },

    -- Window-local options for oil buffers
    win_options = {
      wrap = false,
      signcolumn = "no",
      cursorcolumn = false,
      foldcolumn = "0",
      spell = false,
      list = false,
      conceallevel = 3,
      concealcursor = "nvic",
    },

    -- Show hidden files by default
    view_options = {
      show_hidden = true,
      is_hidden_file = function(name, _)
        return vim.startswith(name, ".")
      end,
      is_always_hidden = function(name, _)
        -- Always hide these
        return name == ".." or name == ".git"
      end,
      natural_order = true,
      sort = {
        { "type", "asc" },
        { "name", "asc" },
      },
    },

    -- Columns to display
    columns = {
      "icon",
    },

    -- Use trash instead of permanent delete
    delete_to_trash = true,
    -- Prompt before destructive operations
    skip_confirm_for_simple_edits = false,
    prompt_save_on_select_new_entry = true,

    -- Keymaps in oil buffer
    keymaps = {
      ["g?"] = "actions.show_help",
      ["<CR>"] = "actions.select",
      ["<C-v>"] = "actions.select_vsplit",
      ["<C-s>"] = "actions.select_split",
      ["<C-t>"] = "actions.select_tab",
      ["<C-p>"] = "actions.preview",
      ["<C-c>"] = "actions.close",
      ["<C-l>"] = "actions.refresh",
      ["-"] = "actions.parent",
      ["_"] = "actions.open_cwd",
      ["`"] = "actions.cd",
      ["~"] = "actions.tcd",
      ["gs"] = "actions.change_sort",
      ["gx"] = "actions.open_external",
      ["g."] = "actions.toggle_hidden",
      ["g\\"] = "actions.toggle_trash",
    },

    -- Preview window settings
    preview = {
      max_width = 0.9,
      min_width = { 40, 0.4 },
      max_height = 0.9,
      min_height = { 5, 0.1 },
      border = "rounded",
      win_options = {
        winblend = 0,
      },
    },

    -- Progress window for operations
    progress = {
      max_width = 0.9,
      min_width = { 40, 0.4 },
      max_height = { 10, 0.9 },
      min_height = { 5, 0.1 },
      border = "rounded",
      minimized_border = "none",
    },

    -- LSP file operations support (rename, move files updates imports)
    lsp_file_methods = {
      enabled = true,
      timeout_ms = 1000,
      autosave_changes = false,
    },
  },
  config = function(_, opts)
    require("oil").setup(opts)

    -- Display current directory in winbar
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "oil",
      callback = function()
        vim.opt_local.winbar = "%{v:lua.require('oil').get_current_dir()}"
      end,
    })
  end,
}
