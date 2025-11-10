return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require 'null-ls'
    null_ls.setup {
      sources = {
        null_ls.builtins.formatting.stylua.with {
          args = { "--config-path", vim.fn.stdpath "config" .. "/stylua.toml", "-" },
        },
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.isort,
        null_ls.builtins.formatting.shfmt,
        null_ls.builtins.formatting.markdownlint,
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.formatting.pg_format,
        null_ls.builtins.formatting.goimports,
        null_ls.builtins.formatting.phpcsfixer,

        null_ls.builtins.diagnostics.vint,

        null_ls.builtins.code_actions.gitrebase,
        null_ls.builtins.code_actions.gomodifytags,
        null_ls.builtins.code_actions.impl,
        null_ls.builtins.code_actions.refactoring,
      },
    }
  end,
}
