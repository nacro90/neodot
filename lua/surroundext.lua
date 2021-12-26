
--- Vim surround extensions

local surroundext = {}

function surroundext.add_keymaps()

   local left = vim.api.nvim_buf_get_mark(0, '<')
   local right = vim.api.nvim_buf_get_mark(0, '>')
end

