return {
  "andythigpen/nvim-coverage",
  dependencies = { "nvim-lua/plenary.nvim" },
  ft = { "go", "python", "lua" },
  keys = {
    { "<leader>tc", "<cmd>CoverageToggle<cr>", desc = "Toggle coverage" },
    { "<leader>tC", "<cmd>CoverageClear<cr>", desc = "Clear coverage" },
    { "<leader>tS", "<cmd>CoverageSummary<cr>", desc = "Coverage summary" },
  },
  config = function()
    require("coverage").setup {
      auto_reload = true,
      lang = {
        go = {
          coverage_file = "coverage.out",
        },
        python = {
          coverage_file = ".coverage",
        },
        lua = {
          coverage_file = "luacov.stats.out",
        },
      },
      signs = {
        covered = { hl = "CoverageCovered", text = "▎" },
        uncovered = { hl = "CoverageUncovered", text = "▎" },
      },
      highlights = {
        covered = { link = "DiagnosticOk" },
        uncovered = { link = "DiagnosticError" },
      },
      summary = {
        min_coverage = 80.0,
      },
    }
  end,
}
