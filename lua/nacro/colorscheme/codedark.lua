---Highlight tweaks for codedark. Nothing to do with vs code

local highlight = require "nacro.utils.highlight"

return function()
  -- highlight("Normal", { guibg = "#1e1e1e" })

  highlight("DiffAdd", { guifg = "NONE", guibg = "#222f22", gui = "NONE" })
  highlight("DiffDelete", { guifg = "NONE", guibg = "#381010" })
  highlight("DiffChange", { guifg = "NONE", guibg = "#3f3327" })
  highlight("DiffText", { guibg = "#5f5347" })

  highlight("NonText", { guibg = "NONE" })
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

  highlight("NvimTreeOpenedFolderName", { gui = "bold", guifg = "#569cd6" })

  highlight("TelescopeMatching", "Identifier")
  highlight("TelescopeBorder", "NonText")
  highlight("TelescopeTitle", "Normal")

  highlight("LspDiagnosticsUnderlineError", { cterm = "underline", gui = "underline" })
  highlight("LspDiagnosticsUnderlineWarning", { cterm = "underline", gui = "underline" })

  highlight("FlutterWidgetGuides", "NonText")

  highlight("CursorLine", { guibg = "#252525" })
  highlight("CursorLineNr", { guibg = "#252525" })

  highlight("TSStrong", { gui = "bold" })
  highlight("TSLiteral", "String")

  highlight("Comment", { gui = "italic" })

  highlight("Folded", { gui = "NONE", guifg = "#777777" })

  highlight("Search", { guibg = "#3b4622" })
  highlight("IncSearch", { guibg = "#5b6642" })

  highlight("TodoDone", "NonText")

  highlight("IndentBlanklineChar", { guibg = "NONE", guifg = "#333333", gui = "nocombine" })
  -- highlight("IndentBlanklineContextChar", { guibg = "NONE", guifg = "#7a7a7a" })

  highlight("Title", "TSStrong")

  highlight("Hlargs", "Special")

  highlight("LspReferenceText", "Underlined")
  highlight("LspReferenceWrite", "Underlined")
  highlight("LspReferenceRead", "Underlined")

  local terminal_colors = {
    "#2d2d2d",
    "#f44747",
    "#6a9955",
    "#d7ba7d",
    "#569cd6",
    "#C586C0",
    "#4ec0b0",
    "#d4d4d4",
    "#808080",
    "#ff8787",
    "#b5cea8",
    "#dcdcaa",
    "#9cdcfe",
    "#c5a6e0",
    "#5fe9c9",
    "#ffffff",
  }
  for i, c in ipairs(terminal_colors) do
    local key = ("terminal_color_%d"):format(i - 1)
    vim.g[key] = c
  end
end
