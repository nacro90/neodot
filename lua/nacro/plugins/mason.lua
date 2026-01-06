return {
  "williamboman/mason.nvim",
  cmd = "Mason",
  event = "VeryLazy",
  opts = {
    ensure_installed = {
      "gopls",
      "black",
      "delve",
      "gopls",
      "goimports",
      "impl",
      "isort",
      "lua-language-server",
      "pyright",
      "shfmt",
      "stylua",
      "typescript-language-server",
      "write-good",
      "yaml-language-server",
    },
  },
}
