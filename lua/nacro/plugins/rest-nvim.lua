return {
  "NTBBloodbath/rest.nvim",
  ft = "http",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    result = {
      show_url = true,
      show_curl_command = true,
      show_http_info = true,
      show_headers = true,
      show_statistics = true,
      formatters = {
        json = "jq",
        html = function(body)
          return vim.fn.system({ "tidy", "-i", "-q", "-" }, body)
        end,
      },
    },
  },
}
