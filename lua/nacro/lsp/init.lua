----------------------------
--- Lsp Configuration Module
----------------------------
local lsp = {}

local lspconfig = require "lspconfig"

local common = require "nacro.lsp.common"
local lua = require "nacro.lsp.lua"
local null = require "nacro.lsp.null"
local go = require "nacro.lsp.go"

function lsp.setup()
  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics,
    {
      virtual_text = false,
      signs = true,
      update_in_insert = false,
    }
  )

  lua.setup()
  null.setup()
  go.setup()

  local lspconfig_names = {
    "hls",
    "dockerls",
    "clangd",
    "pyright",
    "jdtls",
    "flow",
    "svelte",
    "yamlls",
    "tsserver",
    "kotlin_language_server",
    -- "dartls",
    "zls"
  }

  for _, lspconfig_name in ipairs(lspconfig_names) do
    lspconfig[lspconfig_name].setup {
      capabilities = common.create_lsp_capabilities(),
      on_attach = common.on_attach,
    }
  end
end

return lsp
