-- https://kulala.mwco.app/docs/usage
return {
  "mistweaverco/kulala.nvim",
  init = function()
    vim.filetype.add { extension = { http = "http" } }
  end,
  ft = "http",
  opts = {
    q_to_close_float = true,
    default_view = "headers_body",
    icons = {
      inlay = {
        loading = "⋯",
        done = "✔",
        error = "✖",
      },
    },
    winbar = true,
  },
  keys = {
    {
      "<CR>",
      function()
        require("kulala").run()
      end,
      ft = "http",
    },
  },
}
