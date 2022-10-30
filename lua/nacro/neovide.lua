local neovide = {}

function neovide.exists()
  return vim.g.neovide
end

function neovide.setup()
  vim.opt.guifont = "jetbrainsmono Nerd Font:h14:w27"

  vim.g.neovide_hide_mouse_when_typing = false
  vim.g.neovide_transparency = 0.8
  vim.g.neovide_fullscreen = true
  vim.g.neovide_hide_mouse_when_typing = false

  vim.keymap.set("n", "<D-v>", '"+p')
  vim.keymap.set("!", "<D-v>", "<C-r>+")

  vim.cmd "cd ~"
end

function neovide.setup_if_neovide()
  if neovide.exists() then
    neovide.setup()
  end
end

return neovide
