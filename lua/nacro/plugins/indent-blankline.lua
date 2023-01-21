local function config()
  require("indent_blankline").setup {
    char = "·",
    show_trailing_blankline_indent = false,
    max_indent_increase = 2,
    char_highlight_list = {
      "IndentBlanklineChar",
    },
  }
end

return {
  "lukas-reineke/indent-blankline.nvim",
  config = config,
}
