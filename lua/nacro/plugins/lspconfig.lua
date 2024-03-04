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

local configs = {
  hls = {},
  dockerls = {},
  clangd = {},
  pyright = {},
  jdtls = {},
  flow = {},
  svelte = {},
  yamlls = {},
  tsserver = {},
  kotlin_language_server = {},
  dartls = {},
  zls = {},
  jsonls = {},
  bashls = {},
  gopls = {
    on_attach = function(client, _)
      if has_golines() then
        client.server_capabilities.document_formatting = false
      end
    end,
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
  angularls = {
    on_attach = function(_, bufnr)
      vim.keymap.set("n", "<leader>.", function()
        local ng = require "ng"
        local ft = vim.opt.filetype:get()
        if ft == "html" then
          ng.goto_component_with_template_file()
        elseif ft == "typescript" then
          ng.goto_template_for_component()
        end
      end, { buffer = bufnr })
    end,
  },
}

local function config()
  local default_config = {
    capabilities = require("cmp_nvim_lsp").default_capabilities(),
  }
  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "solid",
  })
  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "solid",
  })
  for name, cfg in pairs(configs) do
    cfg = vim.tbl_extend("force", default_config, cfg)
    require("lspconfig")[name].setup(cfg)
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
