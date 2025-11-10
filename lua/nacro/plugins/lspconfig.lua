local function has_golines()
  if vim.fn.executable "golines" ~= 1 then
    return false
  end
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

local function has_prettier()
  if vim.fn.executable "prettier" ~= 1 then
    return false
  end
  local exists, null_ls = pcall(require, "null-ls")
  if not exists then
    return false
  end
  local sources = null_ls.get_sources()
  for _, source in ipairs(sources) do
    if source.name == "prettier" then
      return true
    end
  end
  return false
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
    on_attach = function(client, _)
      if has_prettier() then
        client.server_capabilities.documentFormattingProvider = false
      end
    end,
    settings = {
      typescript = {
        inlayHints = {
          includeInlayEnumMemberValueHints = true,
          includeInlayEnumMemberNameHintsWhenTypeMatchesName = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayParameterNameHints = "all",
        },
      },
      javascript = {
        inlayHints = {
          includeInlayEnumMemberValueHints = true,
          includeInlayEnumMemberNameHintsWhenTypeMatchesName = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayParameterNameHints = "all",
        },
      },
    },
  },
  kotlin_language_server = {},
  dartls = {},
  zls = {},
  bashls = {},
  gopls = {
    on_attach = function(client, _)
      if has_golines() then
        client.server_capabilities.document_formatting = false
      end
    end,
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
  }

  local implementation_handler = vim.lsp.handlers["textDocument/implementation"]
  vim.lsp.handlers["textDocument/implementation"] = vim.lsp.with(implementation_handler, {
    on_list = function(options)
      vim.print "on list"
      vim.print(options)
      vim.fn.setqflist({}, " ", options)
      vim.cmd.cfirst()
    end,
  })
  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "solid",
  })
  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "solid",
  })
  for name, cfg in pairs(configs) do
    cfg = vim.tbl_extend("force", default_config, cfg)
    require("lspconfig")[name].setup(cfg) -- TODO: New lsp initialization
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
    "joeveiga/ng.nvim",
  },
}
