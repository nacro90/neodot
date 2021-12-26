local colorscheme = {}

local fn = vim.fn

function colorscheme.setup(name)
  vim.cmd [[ autocmd! ColorScheme * lua require("nacro.colorscheme").on_colorscheme() ]]

  name = name or "codedark"
  vim.cmd("colorscheme " .. name)

  fn.sign_define("DiagnosticSignError", { text = "▪", texthl = "DiagnosticSignError" })
  fn.sign_define("DiagnosticSignWarn", { text = "▴", texthl = "DiagnosticSignWarn" })
  fn.sign_define("DiagnosticSignInfo", { text = "›", texthl = "DiagnosticSignInfo" })
  fn.sign_define("DiagnosticSignHint", { text = "▸", texthl = "DiagnosticSignHint" })
end

function colorscheme.on_colorscheme()
  local colors_name = vim.g.colors_name

  if not colors_name then
    return
  end

  local exists, tweak = pcall(require, "nacro.colorscheme." .. colors_name)

  if not exists then
    return
  end

  local t = type(tweak)
  if t == "string" then
    vim.cmd(tweak)
  elseif t == "function" then
    tweak()
  end
end

return colorscheme
