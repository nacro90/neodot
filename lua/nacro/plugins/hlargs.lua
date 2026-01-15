return {
  "m-demare/hlargs.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    color = "#ef9062", -- Soft orange for argument highlighting
    excluded_filetypes = {},
    paint_arg_declarations = true,
    paint_arg_usages = true,
    paint_catch_blocks = {
      declarations = false,
      usages = false,
    },
    extras = {
      named_parameters = false,
    },
    hl_priority = 10000,
  },
}
