syntax match mkdCheckBoxChar /[ xX]/ contained
syntax match mkdListItem /^\s*\%([-*+]\|\d\+\.\)\%(\s\[[ xX]\]\)\?\ze\%(\s.*\)\?$/ contained contains=mkdCheckBoxChar
" syntax match OverLength /\%81v.\+/

highlight link mkdCheckBox mkdListItem
highlight link mkdCheckBoxChar SpecialKey
highlight link OverLength ErrorMsg

highlight markdownH1 gui=bold cterm=bold

