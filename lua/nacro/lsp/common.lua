local common = {}

local telescope_builtin = require "telescope.builtin"
local map = require "nacro.utils.map"

local nnoremap = map.nnoremap
local inoremap = map.inoremap
local vnoremap = map.vnoremap
local xnoremap = map.xnoremap

local api = vim.api

function common.on_attach(client, bufnr)
  local buf = vim.lsp.buf
  local diagnostic = vim.diagnostic

  local function show_line_diagnostics()
    vim.diagnostic.open_float(bufnr, { scope = "line" })
  end

  nnoremap("<leader>u", telescope_builtin.lsp_references, bufnr)
  nnoremap("<leader>i", telescope_builtin.lsp_implementations, bufnr)
  nnoremap("gd", buf.definition, bufnr)
  nnoremap("<C-k>", buf.hover, bufnr)
  nnoremap("<C-j>", show_line_diagnostics, bufnr)
  nnoremap("<leader>s", telescope_builtin.lsp_dynamic_workspace_symbols, bufnr)
  nnoremap("<leader>S", telescope_builtin.lsp_document_symbols, bufnr)
  nnoremap("<leader>a", telescope_builtin.lsp_code_actions, bufnr)
  xnoremap("<leader>a", buf.range_code_action, bufnr)
  nnoremap("]d", diagnostic.goto_next, bufnr)
  nnoremap("[d", diagnostic.goto_prev, bufnr)
  nnoremap("g<C-d>", buf.implementation, bufnr)
  nnoremap("<C-q>", buf.signature_help, bufnr)
  inoremap("<C-q>", buf.signature_help, bufnr)
  nnoremap("1gD", buf.type_definition, bufnr)
  nnoremap("gl", buf.formatting, bufnr)
  vnoremap("gl", buf.range_formatting, bufnr)
  nnoremap("<leader>r", buf.rename, bufnr)

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
