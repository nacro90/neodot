local M = {}

function M.setup()
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
    vim.lsp.buf.definition { reuse_win = true }
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
    vim.lsp.buf.type_definition { reuse_win = true }
  end, { desc = "Type definition" })

  set({ "n", "v" }, "gl", vim.lsp.buf.format, { desc = "Format buffer" })
end

return M
