local M = {}

local function delete_all_buffers()
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    vim.api.nvim_buf_delete(bufnr, { force = true })
  end
end

function M.setup()
  vim.api.nvim_create_user_command("CleanSlate", delete_all_buffers, {})
end

return M
