return {
  "m00qek/baleia.nvim",
  version = "*",
  ft = "dap-repl",
  config = function()
    local baleia = require("baleia").setup {
      strip_ansi_codes = true,
      async = true,
    }

    local group = vim.api.nvim_create_augroup("BaleiaDAP", { clear = true })

    vim.api.nvim_create_autocmd("FileType", {
      group = group,
      pattern = "dap-repl",
      callback = function(args)
        baleia.automatically(args.buf)
      end,
    })

    -- Colorize current buffer if already dap-repl (handles lazy load timing)
    vim.schedule(function()
      local buf = vim.api.nvim_get_current_buf()
      if vim.bo[buf].filetype == "dap-repl" then
        baleia.automatically(buf)
      end
    end)
  end,
}
