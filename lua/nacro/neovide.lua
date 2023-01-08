local neovide = {}

function neovide.exists()
  return vim.g.neovide
end

function neovide.set_font_size(size)
  local font = vim.opt.guifont:get()[1]
  vim.opt.guifont = font:gsub(":%w%d+", ":" .. size, 1)
end

function neovide.setup()
  vim.opt.guifont = "jetbrainsmono Nerd Font:h14:w27"

  vim.g.neovide_transparency = 0.8
  vim.g.neovide_hide_mouse_when_typing = true

  vim.keymap.set("n", "<D-v>", '"+p')
  vim.keymap.set("!", "<D-v>", "<C-r>+")
  vim.cmd [[tnoremap <expr> <D-v> '<C-\><C-N>"+pi']]
  vim.keymap.set("n", "<D-f>", function()
    vim.g.neovide_fullscreen = not vim.g.neovide_fullscreen
  end)

  vim.cmd "cd ~"
end

function neovide.setup_if_neovide()
  if not neovide.exists() then
    return
  end
  neovide.setup()
end

return neovide
