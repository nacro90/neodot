return {
  "NTBBloodbath/rest.nvim",
  ft = "http",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    stay_in_current_window_after_split = true,
    result = {
      show_url = true,
      show_curl_command = true,
      show_http_info = true,
      show_headers = true,
      formatters = {
        json = "jq",
        html = function(body)
          return vim.fn.system({ "tidy", "-i", "-q", "-" }, body)
        end,
      },
    },
  },
}
