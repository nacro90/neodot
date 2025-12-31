local M = {}

local api = vim.api

function M.setup()
  -- Highlight yanked text
  api.nvim_create_autocmd("TextYankPost", {
    group = api.nvim_create_augroup("nacro_highlight_yank", {}),
    callback = function()
      vim.highlight.on_yank { higroup = "Visual", timeout = 200 }
    end,
  })

  -- Jump to last known cursor position
  api.nvim_create_autocmd("BufReadPost", {
    group = api.nvim_create_augroup("nacro_last_position", {}),
    callback = function()
      local pos = vim.fn.line "'\""
      if pos > 0 and pos <= api.nvim_buf_line_count(0) then
        vim.cmd 'normal g`"'
      end
    end,
  })
end

return M
