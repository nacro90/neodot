local M = {}
local tabline = require "tabline"

function M.setup()
  tabline.setup {
    enable = true,
    options = {
      section_separators = { " ", " " },
      component_separators = { " ", " " },
      show_filename_only = true,
    },
  }
  vim.cmd [[
    set guioptions-=e " Use showtabline in gui vim
    set sessionoptions+=tabpages,globals " store tabpages and globals in session
  ]]
end

return M
