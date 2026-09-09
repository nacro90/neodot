local M = {}

local document_highlight = "textDocument/documentHighlight"

-- vim-illuminate her imleç hareketinde textDocument/documentHighlight isteği
-- gönderir ve isteği yollamadan önce kendi is_ready() kontrolünü yapar. Go
-- tamponlarında gopls'in yanına null-ls de bağlandığı için, Nvim'in istek
-- anındaki kontrolü bu ön kontrolle çelişebiliyor: istemci listesi boş
-- olmadığı ama o an metodu destekleyen istemci görünmediği için çekirdek
-- "hiçbir sunucu desteklemiyor" bildirimini ERROR seviyesinde basıyor.
-- Bildirim tamamen kozmetik; sadece bu metoda sessiz bir on_unsupported
-- geçiyoruz, diğer LSP metotları etkilenmiyor.
local function silence_unsupported_document_highlight()
  if vim.g.nacro_document_highlight_silenced then
    return
  end
  vim.g.nacro_document_highlight_silenced = true

  local buf_request = vim.lsp.buf_request
  vim.lsp.buf_request = function(bufnr, method, params, handler, on_unsupported)
    if method == document_highlight and on_unsupported == nil then
      on_unsupported = function() end
    end
    return buf_request(bufnr, method, params, handler, on_unsupported)
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
