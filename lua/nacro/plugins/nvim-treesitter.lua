local function config()
  require("nvim-treesitter.configs").setup {
    ensure_installed = "all",
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = { "markdown" },
    },
    textobjects = {
      select = {
        enable = true,
        keymaps = {
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["at"] = "@class.outer",
          ["it"] = "@class.inner",
          ["ig"] = "@block.inner",
          ["ag"] = "@block.outer",
          ["io"] = "@call.inner",
          ["ao"] = "@call.outer",
          ["ij"] = "@conditional.inner",
          ["aj"] = "@conditional.outer",
          ["il"] = "@loop.inner",
          ["al"] = "@loop.outer",
          ["ia"] = "@parameter.inner",
          ["aa"] = "@parameter.outer",
          ["as"] = "@statement.outer",
        },
      },
    },
    indent = { enable = false },
    autotag = { enable = false },
    playground = { enable = true },
  }
end

return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  -- commit = "33eb472b459f1d2bf49e16154726743ab3ca1c6d",
  config = config,
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
    {
      "m-demare/hlargs.nvim",
      config = true,
    },
    {
      "windwp/nvim-ts-autotag",
      ft = {
        "html",
        "svelte",
      },
      config = true,
    },
    "nvim-treesitter/playground",
  },
}
