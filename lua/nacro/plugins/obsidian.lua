local os = require "nacro.os"

return {
  "epwalsh/obsidian.nvim",
  event = { "BufReadPre " .. vim.fn.expand "~" .. "/Zettels/**.md" },
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
  },
  config = function(_, opts)
    local obsidian = require "obsidian"

    obsidian.setup(opts)

    vim.keymap.set("n", "<CR>", function()
      if obsidian.util.cursor_on_markdown_link() then
        return "<Cmd>ObsidianFollowLink<CR>"
      else
        return "<CR>"
      end
    end, {
      expr = true,
    })
  end,
  keys = {
    {
      "<leader>Z",
      "<Cmd>ObsidianNew<CR>",
    },
    {
      "<leader><leader>z",
      "<Cmd>ObsidianSearch<CR>",
    },
  },
}