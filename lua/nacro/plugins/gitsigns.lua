local function config()
  require("gitsigns").setup {
    signs = {
      add = { text = "│" },
      change = { text = "│" },
      delete = { text = "│" },
    },
    keymaps = {
      noremap = true,

      ["n ]h"] = {
        expr = true,
        "&diff ? '<leader>hn' : '<cmd>lua require\"gitsigns\".next_hunk()<CR>'",
      },
      ["n [h"] = {
        expr = true,
        "&diff ? '<leader>hN' : '<cmd>lua require\"gitsigns\".prev_hunk()<CR>'",
      },

      ["n <leader>hs"] = [[<cmd>lua require('gitsigns').stage_hunk()<CR>]],
      ["v <leader>hs"] = '<cmd>lua require"gitsigns".stage_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
      ["n <leader>hu"] = [[<cmd>lua require('gitsigns').undo_stage_hunk()<CR>]],
      ["n <leader>hr"] = [[<cmd>lua require('gitsigns').reset_hunk()<CR>]],
      ["v <leader>hr"] = '<cmd>lua require"gitsigns".reset_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
      ["n <leader>hp"] = [[<cmd>lua require('gitsigns').preview_hunk()<CR>]],
      ["n <leader>hb"] = '<cmd>lua require"gitsigns".blame_line(false)<CR>',
      ["n <leader>hB"] = '<cmd>lua require"gitsigns".blame_line(true)<CR>',
      ["n <leader>hS"] = '<cmd>lua require"gitsigns".stage_buffer()<CR>',
      ["n <leader>hU"] = '<cmd>lua require"gitsigns".reset_buffer_index()<CR>',
      ["n <leader>hR"] = '<cmd>lua require"gitsigns".reset_buffer()<CR>',

      ["o ih"] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>',
      ["x ih"] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>',
    },
    preview_config = {
      border = "none",
    },
  }
end

return {
  "lewis6991/gitsigns.nvim",
  config = config,
}