local neovide = {}

function neovide.set_font_size(size)
  local font = vim.opt.guifont:get()[1]
  vim.opt.guifont = font:gsub(":%w%d+", ":" .. size, 1)
end

function neovide.setup()
  vim.opt.guifont = "jetbrainsmono Nerd Font:h10.5"

  vim.g.neovide_hide_mouse_when_typing = false

  vim.keymap.set("n", "<D-v>", '"+p')
  vim.keymap.set("!", "<D-v>", "<C-r>+")
  vim.cmd [[tnoremap <expr> <D-v> '<C-\><C-N>"+pi']]
  vim.keymap.set("n", "<D-f>", function()
    vim.g.neovide_fullscreen = not vim.g.neovide_fullscreen
  end)
  vim.g.neovide_refresh_rate = 120

  vim.cmd "cd ~"
end

function neovide.setup_if_neovide()
  if not vim.g.neovide then
    return
  end
  neovide.setup()
end

return neovide
