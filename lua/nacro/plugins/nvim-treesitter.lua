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
    autotag = { enable = true },
    rainbow = {
      enable = false,
      disable = {
        "go",
        "python",
        "lua",
        "dart",
      },
    },
    playground = {
      enable = true,
    },
  }
end

return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = config,
  dependencies = {
    "p00f/nvim-ts-rainbow",
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
