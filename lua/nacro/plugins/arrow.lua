return {
  "otavioschwanck/arrow.nvim",
  opts = {
    show_icons = true,
    leader_key = "<leader><leader>",
    separate_by_branch = true,
    index_keys = "ueoa.,kjhtnscrmw'lyfxb",
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
    },
    {
      "]a",
      function()
        require("arrow.persist").next()
      end,
    },
    {
      "<leader>A",
      function()
        require("arrow.persist").toggle()
      end,
    },
  },
}
