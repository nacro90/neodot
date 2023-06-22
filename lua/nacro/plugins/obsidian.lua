local os = require "nacro.os"

return {
  "epwalsh/obsidian.nvim",
  event = { "BufReadPre " .. vim.fn.expand "~" .. "/Zettels/**.md" },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },
  opts = {
    dir = "~/Zettels", -- no need to call 'vim.fn.expand' here
    follow_url_func = function(url)
      vim.fn.jobstart { os.get_opener(), url }
    end,
    disable_frontmatter = false,
    -- Optional, set to true to force ':ObsidianOpen' to bring the app to the foreground.
    -- open_app_foreground = false,
  },
  -- config = function(obsidian, opts)
  --   require("obsidian").setup(opts)
  --
  --   -- Optional, override the 'gf' keymap to utilize Obsidian's search functionality.
  --   -- see also: 'follow_url_func' config option above.
  --   vim.keymap.set("n", "gf", function()
  --     if require("obsidian").util.cursor_on_markdown_link() then
  --       return "<cmd>ObsidianFollowLink<CR>"
  --     else
  --       return "gf"
  --     end
  --   end, {
  --     noremap = false,
  --     expr = true,
  --   })
  -- end,
}
