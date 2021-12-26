---Highlight tweaks for codedark. Nothing to do with vs code

local highlight = require "nacro.utils.highlight"
local g = vim.g

return function()
  highlight("Normal", { guibg = "#1e1e1e" })

  highlight("DiffAdd", { guifg = "NONE", guibg = "#222f22", gui = "NONE" })
  highlight("DiffDelete", { guifg = "NONE", guibg = "#381010" })
  highlight("DiffChange", { guifg = "NONE", guibg = "#3f3327" })
  highlight("DiffText", { guibg = "#5f5347" })

  highlight("NonText", { guibg = "NONE" })
  highlight("IndentBlanklineChar", { guibg = "#222222" })
  highlight("ErrorMsg", { guibg = "NONE" })
  highlight("WarningMsg", { guibg = "NONE" })

  highlight("DiagnosticSignInformation", "Identifier")
  highlight("DiagnosticSignHint", { guifg = "#d4d4d4" })

  highlight("TSOperator", "TSKeywordOperator")
  highlight("TSKeyword", { gui = "bold" })
  highlight("TSVariable", "Normal")

  highlight("VertSplit", { guifg = "#252526" })

  highlight("GitSignsAdd", "Comment")
  highlight("GitSignsChange", "WarningMsg")
  highlight("GitSignsDelete", "ErrorMsg")

  highlight("NeogitUnstagedchanges", "WarningMsg")
  highlight("NeogitStagedchanges", "Float")
  highlight("NeogitUntrackedfiles", "ErrorMsg")
  highlight("NeogitHunkHeader", "NonText")
  highlight("NeogitRemote", "NeogitBranch")
  highlight("LspReferenceText", "Underlined")

  highlight("CmpItemAbbrMatch", "Identifier")
  highlight("CmpItemAbbrDeprecated", "WarningMsg")
  highlight("PmenuSel", { guifg = "NONE" })
  highlight("CmpItemKind", "SpecialKey")

  highlight("CmpItemKindFunction", "Function")
  highlight("CmpItemKindMethod", "Function")
  highlight("CmpItemKindConstant", "Constant")
  highlight("CmpItemKindText", "Comment")
  highlight("CmpItemKindKeyword", "Keyword")
  highlight("CmpItemKindModule", "Constant")
  highlight("CmpItemKindVariable", "Identifier")
  highlight("CmpItemKindFolder", "String")
  highlight("CmpItemKindFile", "Normal")

  highlight("TelescopeMatching", "Identifier")
  highlight("TelescopeBorder", "NonText")
  highlight("TelescopeTitle", "Normal")

  highlight("LspDiagnosticsUnderlineError", { cterm = "underline", gui = "underline" })
  highlight("LspDiagnosticsUnderlineWarning", { cterm = "underline", gui = "underline" })

  highlight("CursorLine", { guibg = "#252525" })
  highlight("CursorLineNr", { guibg = "#252525" })

  highlight("TSStrong", { gui = "bold" })
  highlight("TSLiteral", "String")
end
