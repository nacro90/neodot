return [[
  highlight! ErrorMsg guifg=#fd6389 guibg=NONE gui=bold
  highlight! WarningMsg guifg=#d7af87 guibg=NONE gui=bold
  highlight! link Include Keyword

  highlight! CursorLine guibg=#252525

  highlight! Search guibg=#404040 guifg=NONE
  highlight! link IncSearch Search

  highlight! Normal guifg=#ebe0e0 guibg=NONE
  highlight! Identifier gui=NONE guifg=#ebe0e0

  highlight! Function guifg=#ebe0e0 gui=bold

  highlight! VertSplit guibg=#252525
  highlight! IndentBlanklineChar guibg=#252525

  highlight! NonText ctermfg=NONE ctermbg=235 guifg=#3a3b3f guibg=NONE

  highlight! Visual guibg=#303030

  highlight! Delimiter guifg=#5f5f5f
  highlight! Special guifg=#d7d7ff
  highlight! Constant guifg=#fafafa gui=bold

  highlight! MatchParen guifg=White guibg=NONE gui=bold

  highlight! link MsgArea Normal

  highlight! Todo guibg=NONE guifg=#6c6d63 gui=bold
  highlight! Comment guibg=NONE guifg=#4a4b4f

  highlight! link TSVariable Normal

  highlight! link GitSignsAdd Normal
  highlight! GitSignsChange guifg=#d7af87
  highlight! link GitSignsDelete DiffDelete

  highlight! DiffAdd guifg=NONE guibg=#222f22 gui=NONE
  highlight! DiffText guifg=NONE guibg=#525252 gui=NONE
  highlight! DiffChange guifg=NONE guibg=#322f27 gui=NONE

  highlight! Question guifg=#d7d7ff
  highlight! MoreMsg guifg=#d7d7ff

  highlight! link NvimTreeOpenedFolderName Normal
  highlight! link NvimTreeFolderName Normal
  highlight! link NvimTreeFolderIcon Directory
  highlight! link NvimTreeSpecialFile Special
  highlight! link NvimTreeIndentMarker NonText

  highlight! TelescopeMatching guifg=#7cdce7

  highlight! link FoldColumn LineNr

  highlight! link JsonTSLabel TSVariable
  highlight! link yamlTSField TSVariable

  highlight! link markdownH1 Constant
  highlight! link markdownH2 Function
  highlight! link markdownH3 Function
  highlight! link markdownH4 Function
  highlight! link markdownH5 Function
  highlight! link markdownH6 Function
]]
