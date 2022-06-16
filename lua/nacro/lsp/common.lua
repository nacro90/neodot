local common = {}

local telescope_builtin = require "telescope.builtin"

local api = vim.api
local keymap = vim.keymap

function common.on_attach(client, bufnr)
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
  keymap.set("n", "<leader>a", buf.code_action, { buffer = bufnr })
  keymap.set("x", "<leader>a", buf.range_code_action, { buffer = bufnr })
  keymap.set("n", "]d", diagnostic.goto_next, { buffer = bufnr })
  keymap.set("n", "[d", diagnostic.goto_prev, { buffer = bufnr })
  keymap.set("n", "g<C-d>", buf.implementation, { buffer = bufnr })
  keymap.set("n", "<C-q>", buf.signature_help, { buffer = bufnr })
  keymap.set("i", "<C-q>", buf.signature_help, { buffer = bufnr })
  keymap.set("n", "1gD", buf.type_definition, { buffer = bufnr })
  keymap.set("n", "gl", function()
    buf.format { async = true }
  end, { buffer = bufnr })
  keymap.set("v", "gl", buf.range_formatting, { buffer = bufnr })
  keymap.set("n", "<leader>r", buf.rename, { buffer = bufnr })

  -- cmd [[autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight()]]
  -- cmd [[autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()]]
  -- cmd [[autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()]]
  -- cmd [[autocmd CursorMovedI <buffer> lua vim.lsp.buf.clear_references()]]
  -- cmd [[autocmd InsertEnter <buffer> lua vim.lsp.buf.clear_references()]]
  -- cmd [[autocmd TextChanged <buffer> lua vim.lsp.buf.clear_references()]]

  api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  require("aerial").on_attach(client)

  require("lsp_signature").on_attach(client, bufnr)

  -- if client.resolved_capabilities.code_lens then
  --   require("virtualtypes").on_attach()
  -- end
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
