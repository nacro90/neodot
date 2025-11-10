local neovide = {}

function neovide.get_font_size()
  local guifont = vim.opt.guifont:get()[1]
  local parts = vim.split(guifont, ":")
  for i, part in ipairs(parts) do
    if vim.startswith(part, "h") then
      return tonumber(part:match "h([0-9.]+)")
    end
  end
  vim.notify "Font size not found in guifont"
end

function neovide.set_font_size(size)
  local guifont = vim.opt.guifont:get()[1]
  local parts = vim.split(guifont, ":")
  local foundIndex
  for i, part in ipairs(parts) do
    if vim.startswith(part, "h") then
      foundIndex = i
      break
    end
  end
  if not foundIndex then
    vim.notify "Font size not found in guifont"
  end
  parts[foundIndex] = "h" .. tostring(size)
  vim.opt.guifont = table.concat(parts, ":")
end

function neovide.change_font_size(value)
  neovide.set_font_size(neovide.get_font_size() + value)
end

local DEFAULT_FONT_SIZE = 10

function neovide.setup()
  vim.opt.guifont = "jetbrainsmono Nerd Font:h" .. DEFAULT_FONT_SIZE
  vim.opt.linespace = 12
  vim.g.neovide_hide_mouse_when_typing = true

  vim.keymap.set("n", "<D-v>", '"+p')
  vim.keymap.set("!", "<D-v>", "<C-r>+")
  vim.keymap.set("n", "<C-S-v>", '"+p')
  vim.keymap.set("!", "<C-S-v>", "<C-r>+")
  vim.cmd [[tnoremap <expr> <D-v> '<C-\><C-N>"+pi']]
  vim.cmd [[tnoremap <expr> <C-S-v> '<C-\><C-N>"+pi']]
  vim.g.neovide_refresh_rate = 120

  vim.keymap.set("n", "<C-S-kPlus>", function()
    require("nacro.neovide").change_font_size(0.5)
  end)
  vim.keymap.set("n", "<C-_>", function()
    require("nacro.neovide").change_font_size(-0.5)
  end)

  vim.cmd "cd ~"
end

function neovide.setup_if_neovide()
  if not vim.g.neovide then
    return
  end
  neovide.setup()
end

return neovide
