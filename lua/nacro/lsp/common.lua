local common = {}

local telescope_builtin = require "telescope.builtin"
local saferequire = require("nacro.utils.module").saferequire

local api = vim.api
local keymap = vim.keymap

local function setup_keymaps(bufnr)
  local buf = vim.lsp.buf
  local diagnostic = vim.diagnostic

  local function show_line_diagnostics()
    vim.diagnostic.open_float(bufnr, { scope = "line" })
  end

  keymap.set("n", "<leader>u", telescope_builtin.lsp_references, { buffer = bufnr })
  keymap.set("n", "<leader>i", telescope_builtin.lsp_implementations, { buffer = bufnr })
  keymap.set("n", "gd", buf.definition, { buffer = bufnr })
  keymap.set("n", "<C-k>", buf.hover, { buffer = bufnr })
  keymap.set("n", "<C-j>", show_line_diagnostics, { buffer = bufnr })
  keymap.set("n", "<leader>s", telescope_builtin.lsp_dynamic_workspace_symbols, { buffer = bufnr })
  keymap.set("n", "<leader>S", telescope_builtin.lsp_document_symbols, { buffer = bufnr })
  keymap.set({ "n", "v" }, "<leader>a", buf.code_action, { buffer = bufnr })
  keymap.set("n", "]d", diagnostic.goto_next, { buffer = bufnr })
  keymap.set("n", "[d", diagnostic.goto_prev, { buffer = bufnr })
  keymap.set("n", "g<C-d>", buf.implementation, { buffer = bufnr })
  keymap.set("n", "<C-q>", buf.signature_help, { buffer = bufnr })
  keymap.set("i", "<C-q>", buf.signature_help, { buffer = bufnr })
  keymap.set("n", "1gD", buf.type_definition, { buffer = bufnr })
  keymap.set({ "n", "v" }, "gl", function()
    buf.format { async = true }
  end, { buffer = bufnr })
  keymap.set("n", "<leader>r", buf.rename, { buffer = bufnr })
end

local function setup_illuminate(client)
  saferequire("illuminate", function(illuminate)
    illuminate.on_attach(client)
  end)
end

local function setup_lsp_signature(client, bufnr)
  saferequire("lsp_signature", function(lsp_signature)
    lsp_signature.on_attach(client, bufnr)
  end)
end

function common.on_attach(client, bufnr)
  api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  setup_keymaps(bufnr)

  setup_illuminate(client)
  setup_lsp_signature(client, bufnr)
end

function common.create_lsp_capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = { "documentation", "detail", "additionalTextEdits" },
  }
  return capabilities
end

return common
