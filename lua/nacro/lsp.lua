local M = {}

-- vim-illuminate sends textDocument/documentHighlight on every cursor move,
-- after running its own is_ready() check. In Go buffers null-ls attaches next
-- to gopls, so core's check at request time can disagree with that pre-check:
-- the attached client list is not empty, yet no client appears to support the
-- method at that instant, so core raises its "not supported by any server"
-- notification at ERROR level. The notification is cosmetic, so we pass a
-- silent on_unsupported for this method.
--
-- Fragile dependency (verified on Nvim 0.12.4): illuminate calls
-- vim.lsp.buf_request_all while we wrap vim.lsp.buf_request. It only works
-- because core re-dispatches the request from buf_request_all through the
-- public table field lsp.buf_request. Note also that buf_request is @nodoc in
-- core while buf_request_all is @since 7, so the side we wrap may change
-- without a deprecation cycle. If core turns it into a file-local function,
-- this wrapper silently becomes dead code and the notification comes back.
-- Look here first if it reappears after an Nvim upgrade.
--
-- Scope: every caller that leaves on_unsupported nil is affected, core's
-- vim.lsp.buf.document_highlight() among them (no keymap binds it here).
local function silence_unsupported_document_highlight()
  -- Escape hatch: setting this flag before M.setup() runs skips the wrapper
  -- entirely; setting it false afterwards does not uninstall one. The same flag
  -- keeps wrappers from stacking on config reload, where a module-local flag
  -- would be reset as soon as package.loaded is cleared.
  if vim.g.nacro_document_highlight_silenced then
    return
  end
  vim.g.nacro_document_highlight_silenced = true

  local function noop() end
  local document_highlight = vim.lsp.protocol.Methods.textDocument_documentHighlight
  local buf_request = vim.lsp.buf_request
  vim.lsp.buf_request = function(bufnr, method, params, handler, on_unsupported, ...)
    if method == document_highlight and on_unsupported == nil then
      on_unsupported = noop
    end
    return buf_request(bufnr, method, params, handler, on_unsupported, ...)
  end
end

function M.setup()
  silence_unsupported_document_highlight()

  -- Diagnostic configuration
  vim.diagnostic.config {
    virtual_text = {
      severity = { min = vim.diagnostic.severity.ERROR },
    },
    underline = {
      severity = { min = vim.diagnostic.severity.WARN },
    },
  }

  -- LSP keymaps
  local set = vim.keymap.set

  set("n", "gd", function()
    require("telescope.builtin").lsp_definitions { reuse_win = true }
  end, { desc = "Go to definition" })

  set("n", "<C-k>", function()
    vim.lsp.buf.hover { border = "solid" }
  end, { desc = "Hover documentation" })
  set("n", "<C-j>", vim.diagnostic.open_float, { desc = "Diagnostic float" })
  set({ "n", "v" }, "<leader>a", vim.lsp.buf.code_action, { desc = "Code actions" })

  set("n", "]d", function()
    vim.diagnostic.jump {
      count = 1,
      float = true,
      severity = { min = vim.diagnostic.severity.WARN },
    }
  end, { desc = "Next diagnostic" })

  set("n", "[d", function()
    vim.diagnostic.jump {
      count = -1,
      float = true,
      severity = { min = vim.diagnostic.severity.WARN },
    }
  end, { desc = "Previous diagnostic" })

  set({ "i", "n" }, "<C-q>", function()
    vim.lsp.buf.signature_help { border = "solid" }
  end, { desc = "Signature help" })

  set("n", "gD", function()
    require("telescope.builtin").lsp_type_definitions { reuse_win = true }
  end, { desc = "Type definition" })

  set({ "n", "v" }, "gl", vim.lsp.buf.format, { desc = "Format buffer" })
end

return M
