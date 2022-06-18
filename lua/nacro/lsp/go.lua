local go = {}

local common = require "nacro.lsp.common"
local lspconfig = require "lspconfig"

local function has_golines()
  local exists, null_ls = pcall(require, "null-ls")
  if not exists then
    return false
  end
  local sources = null_ls.get_sources()
  for _, source in ipairs(sources) do
    if source.name == "golines" then
      return true
    end
  end
  return false
end

local function on_attach(client, bufnr)
  common.on_attach(client, bufnr)

  if has_golines() then
    client.server_capabilities.document_formatting = false
  end
end

function go.setup()
  lspconfig.gopls.setup {
    on_attach = on_attach,
    -- TODO? capabilities = common.create_lsp_capabilities()
  }
end

return go
