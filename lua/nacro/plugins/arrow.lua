return {
  "otavioschwanck/arrow.nvim",
  opts = {
    show_icons = true,
    leader_key = "<leader><leader>",

    -- Don't separate by branch - same bookmarks across all branches
    separate_by_branch = false,

    -- Dvorak-optimized: home row first (10 bookmarks max)
    -- Left home:  a o e u
    -- Right home: h t n s
    -- Easy reach: i d
    index_keys = "aoeuhtnsid",

    mappings = {
      edit = "<C-e>",
    },

    window = {
      border = "none",
    },
  },
  keys = {
    "<leader><leader>",
    {
      "[a",
      function()
        require("arrow.persist").previous()
      end,
      desc = "Previous arrow bookmark",
    },
    {
      "]a",
      function()
        require("arrow.persist").next()
      end,
      desc = "Next arrow bookmark",
    },
    {
      "<leader>A",
      function()
        require("arrow.persist").toggle()
      end,
      desc = "Toggle arrow bookmark",
    },
  },
}
