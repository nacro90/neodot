local colorscheme = {}

local function on_colorscheme()
  local colors_name = vim.g.colors_name

  if not colors_name then
    return
  end

  local exists, tweak = pcall(require, "nacro.colorscheme." .. colors_name)

  if not exists then
    return
  end

  if type(tweak) == "string" then
    vim.cmd(tweak)
  elseif type(tweak) == "function" then
    tweak()
  end
end

function colorscheme.setup(name)
  vim.api.nvim_create_autocmd("ColorScheme", {
    group = vim.api.nvim_create_augroup("colorscheme_tweaks", {}),
    pattern = "*",
    callback = on_colorscheme,
  })

  vim.cmd("colorscheme " .. name)

  vim.diagnostic.config {
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = "▪",
        [vim.diagnostic.severity.WARN] = "▴",
        [vim.diagnostic.severity.INFO] = "›",
        [vim.diagnostic.severity.HINT] = "▸",
      },
    },
  }
end

return colorscheme
