local nos = require "nacro.os"

local function scratch_popup()
  local width = 80
  local height = 20
  local buf = vim.api.nvim_create_buf(false, true)
  local ui = vim.api.nvim_list_uis()[1]
  local opts = {
    relative = "editor",
    width = width,
    height = height,
    col = (ui.width / 2) - (width / 2),
    row = (ui.height / 2) - (height / 2),
    anchor = "NW",
    style = "minimal",
    border = "solid",
  }
  local win = vim.api.nvim_open_win(buf, true, opts)
  vim.keymap.set("n", "<leader>C", function()
    vim.print "o ye"
    vim.api.nvim_win_close(win, true)
  end, { buffer = buf })

  vim.cmd "edit ~/Zettels/scratch.md"
  vim.cmd "normal G"
end

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
      vim.fn.jobstart { nos.get_opener(), url }
    end,
    note_id_func = function(title)
      if not title then
        title = vim.fn.input "New zettel: "
      end
      title = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
      return title
    end,
    image_name_func = function()
      return string.format("%s-", os.time())
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
      img_text_func = function(client, path)
        path = client:vault_relative_path(path) or path
        return string.format("![[%s]]", path)
      end,
    },
  },
  keys = {
    {
      "<leader>z",
      "<Cmd>ObsidianQuickSwitch<CR>",
    },
    {
      "<leader>Z",
      scratch_popup,
    },
  },
}
