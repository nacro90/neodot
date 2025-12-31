local set = vim.keymap.set

--- Nops
set("n", "Q", "<Nop>")
set("n", "<leader>", "<Nop>", { remap = true })
set({ "i", "n", "v" }, "<F1>", "<Nop>")
set("n", "-", "<Nop>")
set("n", "<BS>", "<NOP>")
set("n", "<CR>", "<NOP>")

set("n", "'", "`")
set("n", "zz", "zzzH")
for _, key in ipairs { "j", "k", "^" } do
  set({ "n", "v" }, key, "g" .. key, { remap = true, silent = true })
end

set("n", "<leader>>", "<Cmd>tabmove +<CR>")
set("n", "<leader><lt>", "<Cmd>tabmove -<CR>")
set("n", "<C-w>n", "<Cmd>vertical new<CR>")
set("n", "<C-w><C-n>", "<Cmd>vertical new<CR>")
set("n", "yon", "<Cmd>setlocal number!<CR>")
set("n", "yor", "<Cmd>setlocal relativenumber!<CR>")
set("n", "yow", "<Cmd>setlocal wrap!<CR>")
set("n", "yoc", "<Cmd>setlocal cursorline!<CR>")
set("n", "yos", "<Cmd>setlocal spell!<CR>")
set("n", "]p", "o<C-r>+<Esc>")
set("n", "[p", "O<C-r>+<Esc>")

--- TODO
set("x", "il", "g_o^")
set("o", "il", "<Cmd>normal vil<CR>")
set("x", "al", "$o^")
set("o", "al", "<Cmd>normal val<CR>")

set("c", "%%", require("nacro.functions").expand_percentage_if_in_command, { expr = true })
set("n", "<leader>ef", require("nacro.functions").configure_filetype)

-- Scroll acceleration
set({ "n", "v" }, "<C-e>", "3<C-e>")
set({ "n", "v" }, "<C-y>", "3<C-y>")

-- Kitty integration
set("n", "<C-w>N", function()
  require("nacro.kitty").buffer_to_new_window()
end, { desc = "Open buffer in new kitty window" })
