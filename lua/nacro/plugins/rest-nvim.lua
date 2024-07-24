return {
  "NTBBloodbath/rest.nvim",
  ft = "http",
  dependencies = { "luarocks.nvim" },
  main = "rest-nvim",
  opts = {
    logs = {
      level = "warn",
      save = true,
    },
    keybinds = {
      {
        "<CR>",
        "<Cmd>Rest run<CR>",
        "Run request under the cursor",
      },
    },
    result = {
      split = {
        stay_in_current_window_after_split = true,
      },
      --   show_url = true,
      --   show_curl_command = true,
      --   show_http_info = true,
      --   show_headers = true,
      --   formatters = {
      --     json = "jq",
      --     html = function(body)
      --       return vim.fn.system({ "tidy", "-i", "-q", "-" }, body)
      --     end,
      --   },
    },
  },
}
