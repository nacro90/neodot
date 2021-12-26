local lua = {}

local common = require "nacro.lsp.common"
local lspconfig = require "lspconfig"

function lua.setup()
  local path = vim.split(package.path, ";")

  -- this is the ONLY correct way to setup your path
  path[#path + 1] = "lua/?.lua"
  path[#path + 1] = "lua/?/init.lua"

  local library = {}
  local function add(lib)
    for _, p in pairs(vim.fn.expand(lib, false, true)) do
      p = vim.loop.fs_realpath(p)
      library[p] = true
    end
  end

  -- add runtime
  add "$VIMRUNTIME"

  -- add your config
  add "~/.config/nvim"

  -- add plugins
  -- if you're not using packer, then you might need to change the paths below
  add "~/.local/share/nvim/site/pack/packer/opt/*"
  add "~/.local/share/nvim/site/pack/packer/start/*"

  local system_name = "macOS"
  -- set the path to the sumneko installation; if you previously installed via the now deprecated :LspInstall, use
  local sumneko_root_path = vim.fn.stdpath "data" .. "/language-servers/lua-language-server"
  local sumneko_binary = sumneko_root_path .. "/bin/" .. system_name .. "/lua-language-server"

  lspconfig.sumneko_lua.setup {
    capabilities = common.create_lsp_capabilities(),
    cmd = { sumneko_binary, "-E", sumneko_root_path .. "/main.lua" },
    on_attach = common.on_attach,
    settings = {
      Lua = {
        runtime = { version = "LuaJIT", path = path },
        completion = { keywordSnippet = "Disable" },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = library,
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
