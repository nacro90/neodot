local M = {}

local command = require "nacro.utils.command"
local api = vim.api
local fn = vim.fn

function M.setup()
  -- Debug/Development
  command("LuaHas", function(keys)
    vim.notify(vim.inspect(pcall(require, keys.args)))
  end, { nargs = 1 })

  -- Editing utilities
  command("RemoveTrailingWhitespace", [[silent! %substitute/\s\+$//]], { nargs = 0 })

  command("RenameBuffer", function(arg)
    local name
    if arg and #arg > 0 then
      name = arg
    else
      name = fn.input "Buffer name: "
      if not name or #name == 0 then
        return
      end
    end
    api.nvim_buf_set_name(0, name)
  end, { nargs = "?" })

  command("TimestampToDatetime", function(a)
    a = a.args
    print(os.date("%Y-%m-%d %H:%M:%S", a / 1000) .. "." .. a % 1000)
  end, { nargs = 1 })

  -- LSP utilities
  command("LspRestart", function(opts)
    local filter = { bufnr = 0 }
    if opts.args and #opts.args > 0 then
      filter.name = opts.args
    end
    for _, client in ipairs(vim.lsp.get_clients(filter)) do
      if client.name ~= "null-ls" then
        local bufs = vim.lsp.get_buffers_by_client_id(client.id)
        client:stop()
        vim.defer_fn(function()
          for _, buf in ipairs(bufs) do
            vim.lsp.start(client.config, { bufnr = buf })
          end
        end, 100)
      end
    end
  end, { nargs = "?", complete = "lsp", bang = true, desc = "Restart LSP servers (excluding null-ls)" })

  -- Typo corrections
  command("W", "w")
  command("Q", "q")
  command("Wq", "wq")
  command("WQ", "wq")
end

return M
