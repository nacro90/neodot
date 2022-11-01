local colorscheme = {}

local fn = vim.fn

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

  fn.sign_define("DiagnosticSignError", { text = "▪", texthl = "DiagnosticSignError" })
  fn.sign_define("DiagnosticSignWarn", { text = "▴", texthl = "DiagnosticSignWarn" })
  fn.sign_define("DiagnosticSignInfo", { text = "›", texthl = "DiagnosticSignInfo" })
  fn.sign_define("DiagnosticSignHint", { text = "▸", texthl = "DiagnosticSignHint" })
end

return colorscheme
