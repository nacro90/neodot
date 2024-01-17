local highlight = require "nacro.utils.highlight"

return function()
  highlight("Visual", { guibg = "#3b4252" })
  highlight("DapExecutionLine", { guibg = "#384752" })
  highlight("DapBreakpointLine", { guibg = "#43343e" })
  highlight("DapUIDecoration", "NvimTreeFolderIcon")
  highlight("DapUIScope", "Title")
  highlight("DapUIVariable", "Keyword")
  highlight("DapUISource ", "Special")
  highlight("DapUIValue", "Normal")
  highlight("DapUILineNumber", "Number")
  highlight("DapUIStoppedThread", "Function")
  highlight("DapUIThread", "Tag")
  highlight("DapUIDecoration", "NvimTreeFolderIcon")
  highlight("IncSearch", "Visual")
  highlight("Search", "Visual")
end
