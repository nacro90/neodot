local function config()
  local null_ls = require "null-ls"
  local formatters = null_ls.builtins.formatting
  local diagnostics = null_ls.builtins.diagnostics
  local code_actions = null_ls.builtins.code_actions

  null_ls.setup {
    sources = {
      formatters.stylua.with {
        args = { "--config-path", vim.fn.stdpath "config" .. "/stylua.toml", "-" },
      },

      formatters.black,
      formatters.isort,
      formatters.shfmt,
      formatters.json_tool,

      formatters.golines,
      formatters.goimports,
      formatters.gofumpt,
      diagnostics.staticcheck,

      diagnostics.shellcheck,
      diagnostics.vint,

      code_actions.gitrebase,
    },
  }
end

return {
  "jose-elias-alvarez/null-ls.nvim",
  ft = { "go", "python", "lua", "sh", "bash", "zsh", "vim" },
  config = config,
}
