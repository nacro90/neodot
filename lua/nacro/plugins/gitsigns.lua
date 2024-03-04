local function gitsigns_req(func, ...)
  local args = { ... }
  return function()
    require("gitsigns")[func](unpack(args))
  end
end

local function on_attach(bufnr)
  vim.keymap.set("n", "]h", gitsigns_req "next_hunk", { desc = "Next hunk", buffer = bufnr })
  vim.keymap.set("n", "[h", gitsigns_req "prev_hunk", { desc = "Previous hunk", buffer = bufnr })
  vim.keymap.set(
    "n",
    "<leader>hs",
    gitsigns_req "stage_hunk",
    { desc = "Stage hunk", buffer = bufnr }
  )
  vim.keymap.set("v", "<leader>hs", function()
    require("gitsigns").stage_hunk { vim.fn.line ".", vim.fn.line "v" }
  end, { desc = "Stage hunk visual", buffer = bufnr })
  vim.keymap.set(
    "n",
    "<leader>hS",
    gitsigns_req "stage_buffer",
    { desc = "Stage buffer", buffer = bufnr }
  )
  vim.keymap.set(
    "n",
    "<leader>hu",
    gitsigns_req "undo_stage_hunk",
    { desc = "Undo stage hunk", buffer = bufnr }
  )
  vim.keymap.set(
    "n",
    "<leader>hr",
    gitsigns_req "reset_hunk",
    { desc = "Reset hunk", buffer = bufnr }
  )
  vim.keymap.set("v", "<leader>hr", function()
    require("gitsigns").stage_hunk { vim.fn.line ".", vim.fn.line "v" }
  end, { desc = "Reset hunk visual", buffer = bufnr })
  vim.keymap.set(
    "n",
    "<leader>hp",
    gitsigns_req "preview_hunk",
    { desc = "Preview hunk", buffer = bufnr }
  )
  vim.keymap.set(
    "n",
    "<leader>hb",
    gitsigns_req "blame_line",
    { desc = "Blame line", buffer = bufnr }
  )
  vim.keymap.set(
    "n",
    "<leader>hU",
    gitsigns_req "reset_buffer_index",
    { desc = "Reset buffer index", buffer = bufnr }
  )
  vim.keymap.set(
    "n",
    "<leader>hR",
    gitsigns_req "reset_buffer",
    { desc = "Reset buffer index", buffer = bufnr }
  )
  vim.keymap.set({ "x", "o" }, "ih", function()
    require("gitsigns.actions").select_hunk()
  end, { desc = "Select hunk", buffer = bufnr })
  return true
end

return {
  "lewis6991/gitsigns.nvim",
  opts = {
    signs = {
      add = { text = "│" },
      change = { text = "│" },
      delete = { text = "│" },
      untracked = { text = "│" },
    },
    preview_config = {
      border = "solid",
    },
    on_attach = on_attach,
  },
  config = function(_, opts)
    require("gitsigns").setup(opts)
  end,
}
