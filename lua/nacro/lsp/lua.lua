local lua = {}

local common = require "nacro.lsp.common"
local lspconfig = require "lspconfig"

local fn = vim.fn
local uv = vim.loop

local data = fn.stdpath "data"
local config = fn.stdpath "config"

local function create_path_list()
  local paths = vim.split(package.path, ";")
  table.insert(paths, "lua/?.lua")
  table.insert(paths, "lua/?/init.lua")
  return paths
end

local function create_library()
  local library = {}

  local function add(lib_path)
    for _, p in pairs(fn.expand(lib_path, false, true)) do
      library[uv.fs_realpath(p)] = true
    end
  end

  add "$VIMRUNTIME"
  add(config)
  add(data .. "/site/pack/packer/opt/*")
  add(data .. "/site/pack/packer/start/*")

  return library
end

function lua.setup()
  lspconfig.sumneko_lua.setup {
    capabilities = common.create_lsp_capabilities(),
    on_attach = common.on_attach,
    settings = {
      Lua = {
        runtime = { version = "LuaJIT", path = create_path_list() },
        completion = { keywordSnippet = "Disable" },
        workspace = {
          library = create_library(),
          maxPreload = 2000,
          preloadFileSize = 50000,
        },
      },
      completion = { callSnippet = "Both" },
      diagnostics = { enable = true, globals = { "describe", "it", "vim" } },
      telemetry = { enable = false },
    },
  }
end

return lua
