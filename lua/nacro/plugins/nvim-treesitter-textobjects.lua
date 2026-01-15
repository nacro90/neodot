-- nvim-treesitter-textobjects configuration (new API)
-- Provides syntax-aware text objects, movements, and swap operations

return {
  "nvim-treesitter/nvim-treesitter-textobjects",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    local ts_textobjects = require("nvim-treesitter-textobjects")

    ts_textobjects.setup {
      select = {
        lookahead = true,
        selection_modes = {
          ["@parameter.outer"] = "v",
          ["@function.outer"] = "V",
          ["@class.outer"] = "V",
        },
        include_surrounding_whitespace = false,
      },
    }

    local select = require("nvim-treesitter-textobjects.select")
    local move = require("nvim-treesitter-textobjects.move")
    local swap = require("nvim-treesitter-textobjects.swap")

    -- Helper to create textobject keymap
    local function textobj(keys, query, desc)
      vim.keymap.set({ "x", "o" }, keys, function()
        select.select_textobject(query, "textobjects")
      end, { desc = desc })
    end

    -- Text object selections
    textobj("af", "@function.outer", "Select outer function")
    textobj("if", "@function.inner", "Select inner function")
    textobj("at", "@class.outer", "Select outer class")
    textobj("it", "@class.inner", "Select inner class")
    textobj("aa", "@parameter.outer", "Select outer argument")
    textobj("ia", "@parameter.inner", "Select inner argument")
    textobj("ai", "@conditional.outer", "Select outer conditional")
    textobj("ii", "@conditional.inner", "Select inner conditional")
    textobj("al", "@loop.outer", "Select outer loop")
    textobj("il", "@loop.inner", "Select inner loop")
    textobj("ab", "@block.outer", "Select outer block")
    textobj("ib", "@block.inner", "Select inner block")
    textobj("ac", "@call.outer", "Select outer call")
    textobj("ic", "@call.inner", "Select inner call")
    textobj("a/", "@comment.outer", "Select outer comment")
    textobj("i/", "@comment.inner", "Select inner comment")

    -- Movement keymaps
    local function goto_next(keys, query, desc)
      vim.keymap.set({ "n", "x", "o" }, keys, function()
        move.goto_next_start(query, "textobjects")
      end, { desc = desc })
    end

    local function goto_prev(keys, query, desc)
      vim.keymap.set({ "n", "x", "o" }, keys, function()
        move.goto_previous_start(query, "textobjects")
      end, { desc = desc })
    end

    local function goto_next_end(keys, query, desc)
      vim.keymap.set({ "n", "x", "o" }, keys, function()
        move.goto_next_end(query, "textobjects")
      end, { desc = desc })
    end

    local function goto_prev_end(keys, query, desc)
      vim.keymap.set({ "n", "x", "o" }, keys, function()
        move.goto_previous_end(query, "textobjects")
      end, { desc = desc })
    end

    -- Go to next start
    goto_next("]f", "@function.outer", "Next function start")
    goto_next("]t", "@class.outer", "Next class start")
    goto_next("]a", "@parameter.inner", "Next argument")
    goto_next("]i", "@conditional.outer", "Next conditional")
    goto_next("]l", "@loop.outer", "Next loop")
    goto_next("]c", "@call.outer", "Next call")
    goto_next("]/", "@comment.outer", "Next comment")

    -- Go to next end
    goto_next_end("]F", "@function.outer", "Next function end")
    goto_next_end("]T", "@class.outer", "Next class end")

    -- Go to previous start
    goto_prev("[f", "@function.outer", "Previous function start")
    goto_prev("[t", "@class.outer", "Previous class start")
    goto_prev("[a", "@parameter.inner", "Previous argument")
    goto_prev("[i", "@conditional.outer", "Previous conditional")
    goto_prev("[l", "@loop.outer", "Previous loop")
    goto_prev("[c", "@call.outer", "Previous call")
    goto_prev("[/", "@comment.outer", "Previous comment")

    -- Go to previous end
    goto_prev_end("[F", "@function.outer", "Previous function end")
    goto_prev_end("[T", "@class.outer", "Previous class end")

    -- Swap keymaps
    vim.keymap.set("n", "<leader>sa", function()
      swap.swap_next("@parameter.inner", "textobjects")
    end, { desc = "Swap with next argument" })

    vim.keymap.set("n", "<leader>sA", function()
      swap.swap_previous("@parameter.inner", "textobjects")
    end, { desc = "Swap with previous argument" })

    vim.keymap.set("n", "<leader>sf", function()
      swap.swap_next("@function.outer", "textobjects")
    end, { desc = "Swap with next function" })

    vim.keymap.set("n", "<leader>sF", function()
      swap.swap_previous("@function.outer", "textobjects")
    end, { desc = "Swap with previous function" })

    -- Make movements repeatable with ; and ,
    local ts_repeat = require("nvim-treesitter-textobjects.repeatable_move")
    vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat.repeat_last_move_next)
    vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat.repeat_last_move_previous)
    -- Also make builtin f, F, t, T repeatable
    vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat.builtin_f_expr, { expr = true })
    vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat.builtin_F_expr, { expr = true })
    vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat.builtin_t_expr, { expr = true })
    vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat.builtin_T_expr, { expr = true })
  end,
}
