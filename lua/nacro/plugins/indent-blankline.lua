return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  opts = {
    indent = {
      char = "▏",
      highlight = "Conceal",
    },
    scope = {
      enabled = true,
      highlight = "CursorLineNr",
      show_start = false,
      show_end = false,
      char = "▎",
    },
  },
}
