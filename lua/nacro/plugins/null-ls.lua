local function config()
  local null_ls = require "null-ls"
  local formatting = null_ls.builtins.formatting
  local diagnostics = null_ls.builtins.diagnostics
  local code_actions = null_ls.builtins.code_actions

  null_ls.setup {
    sources = {
      formatting.stylua.with {
        args = { "--config-path", vim.fn.stdpath "config" .. "/stylua.toml", "-" },
      },
      formatting.black,
      formatting.isort,
      formatting.shfmt,
      formatting.jq,
      formatting.sql_formatter,
      formatting.markdownlint,
      formatting.prettier.with {
        filetypes = { "html" },
      },
      -- formatters.golines,
      formatting.goimports,
      -- formatters.gofumpt,

      diagnostics.shellcheck,
      diagnostics.vint,
      diagnostics.sqlfluff.with {
        extra_args = { "--dialect", "postgres" }, -- change to your dialect
      },

      code_actions.gitrebase,
    },
  }
end

return {
  "nvimtools/none-ls.nvim",
  config = config,
}
