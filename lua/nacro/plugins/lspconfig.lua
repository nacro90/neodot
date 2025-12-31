local function has_null_ls_formatter(bufnr)
  local ok, sources = pcall(require, "null-ls.sources")
  if not ok then
    return false
  end
  local ft = vim.bo[bufnr].filetype
  local available = sources.get_available(ft, "NULL_LS_FORMATTING")
  return #available > 0
end

local configs = {
  hls = {},
  dockerls = {},
  clangd = {},
  pyright = {},
  jdtls = {},
  flow = {},
  svelte = {},
  yamlls = {},
  ts_ls = {
    settings = (function()
      local inlayHints = {
        includeInlayEnumMemberValueHints = true,
        includeInlayEnumMemberNameHintsWhenTypeMatchesName = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayParameterNameHints = "all",
      }
      return { typescript = { inlayHints = inlayHints }, javascript = { inlayHints = inlayHints } }
    end)(),
  },
  kotlin_language_server = {},
  dartls = {},
  zls = {},
  bashls = {},
  gopls = {
    settings = {
      gopls = {
        completeUnimported = true,
        usePlaceholders = false,
        analyses = {
          unusedparams = true,
        },
        hints = {
          assignVariableTypes = false,
          compositeLiteralFields = true,
          compositeLiteralTypes = true,
          rangeVariableTypes = true,
          parameterNames = false,
          constantValues = true,
        },
      },
    },
  },
  lua_ls = {
    settings = {
      Lua = {
        runtime = { version = "LuaJIT" },
        diagnostics = {
          globals = { "vim", "describe", "it" },
        },
        workspace = {
          library = vim.api.nvim_get_runtime_file("", true),
          checkThirdParty = false,
        },
        telemetry = { enable = false },
      },
    },
  },
  phpactor = {},
}

local function config()
  vim.lsp.inlay_hint.enable(false)
  local default_config = {
    capabilities = require("cmp_nvim_lsp").default_capabilities(),
    on_attach = function(client, bufnr)
      if has_null_ls_formatter(bufnr) then
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
      end
    end,
  }

  -- Configure and enable LSP servers using vim.lsp.config (Nvim 0.11+)
  for name, cfg in pairs(configs) do
    cfg = vim.tbl_extend("force", default_config, cfg)
    vim.lsp.config(name, cfg)
    vim.lsp.enable(name)
  end
end

return {
  "neovim/nvim-lspconfig",
  config = config,
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    {
      "smjonas/inc-rename.nvim",
      keys = {
        {
          "<leader>r",
          function()
            vim.api.nvim_feedkeys(":IncRename " .. vim.fn.expand "<cword>", "n", false)
          end,
        },
      },
      config = true,
    },
  },
}

