local os = require "nacro.os"

return {
  "epwalsh/obsidian.nvim",
  version = "*",
  ft = "markdown",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },
  opts = {
    dir = "~/Zettels",
    follow_url_func = function(url)
      vim.fn.jobstart { os.get_opener(), url }
    end,
    note_id_func = function(title)
      if not title then
        title = vim.fn.input "New zettel: "
      end
      title = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
      return title
    end,
    ui = {
      checkboxes = {
        [" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
        ["x"] = { char = "", hl_group = "ObsidianDone" },
      },
    },
    daily_notes = {
      folder = "daily",
      -- date_format = "%Y-%m-%d",
      -- -- Optional, if you want to change the date format of the default alias of daily notes.
      -- alias_format = "%B %-d, %Y",
      -- -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
      -- template = nil
    },
    attachments = {
      img_folder = "static",
    },
  },
  keys = {
    {
      "<leader>z",
      "<Cmd>ObsidianQuickSwitch<CR>",
    },
    {
      "<leader>Z",
      "<Cmd>ObsidianDailies<CR>",
    },
  },
}
