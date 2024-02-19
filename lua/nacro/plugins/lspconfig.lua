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

local function setup_keymaps(bufnr)
  local tb = require "telescope.builtin"
  vim.keymap.set("n", "<leader>u", tb.lsp_references, { buffer = bufnr })
  vim.keymap.set("n", "<leader>i", tb.lsp_implementations, { buffer = bufnr })
  vim.keymap.set("n", "<leader>s", function()
    tb.lsp_dynamic_workspace_symbols { fname_width = 80, symbol_width = 80 } -- TODO: make dynamic
  end, { buffer = bufnr })
  vim.keymap.set("n", "<leader>S", tb.lsp_document_symbols, { buffer = bufnr })
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr })
  vim.keymap.set("n", "<C-k>", vim.lsp.buf.hover, { buffer = bufnr })
  vim.keymap.set("n", "<C-j>", vim.diagnostic.open_float, { buffer = bufnr })
  vim.keymap.set({ "n", "v" }, "<leader>a", vim.lsp.buf.code_action, { buffer = bufnr })
  vim.keymap.set("n", "]d", function()
    vim.diagnostic.goto_next {
      severity = { min = vim.diagnostic.severity.WARN },
    }
  end, { buffer = bufnr })
  vim.keymap.set("n", "[d", function()
    vim.diagnostic.goto_next {
      severity = { min = vim.diagnostic.severity.WARN },
    }
  end, { buffer = bufnr })
  vim.keymap.set("n", "<C-q>", vim.lsp.buf.signature_help, { buffer = bufnr })
  vim.keymap.set("i", "<C-q>", vim.lsp.buf.signature_help, { buffer = bufnr })
  vim.keymap.set("n", "gD", vim.lsp.buf.type_definition, { buffer = bufnr })
  vim.keymap.set({ "n", "v" }, "gl", vim.lsp.buf.format, { buffer = bufnr })
  -- vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, { buffer = bufnr })
end

local function on_attach(client, bufnr)
  setup_keymaps(bufnr)
  if client.server_capabilities.documentSymbolProvider then
    require("nvim-navic").attach(client, bufnr)
  end
  require("lsp_signature").on_attach(client)
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
  gopls = {
    on_attach = function(client, bufnr)
      on_attach(client, bufnr)
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
}

local function config()
  local default_config = {
    capabilities = require("cmp_nvim_lsp").default_capabilities(),
    on_attach = on_attach,
  }
  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "solid",
  })
  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "solid",
  })
  local _, exists = pcall(require, "flutter-tools")
  if exists and configs.dartls then
    configs.dartls = nil
  end
  for name, cfg in pairs(configs) do
    cfg = vim.tbl_extend("force", default_config, cfg)
    require("lspconfig")[name].setup(cfg)
  end
end

return {
  "neovim/nvim-lspconfig",
  config = config,
  ft = {
    "c",
    "cpp",
    "dockerfile",
    "go",
    "javascript",
    "kotlin",
    "lua",
    "python",
    "svelte",
    "typescript",
    "yaml",
    "zig",
    "dart",
    "java",
  },
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "hrsh7th/cmp-nvim-lsp",
    "ray-x/lsp_signature.nvim",
    "SmiteshP/nvim-navic",
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
  on_attach = on_attach,
}
