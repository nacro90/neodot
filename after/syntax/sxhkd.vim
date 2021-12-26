

" Modifiers
" syntax keyword SxhkdModifier alt
" syntax keyword SxhkdModifier ctrl
" syntax keyword SxhkdModifier shift
" syntax keyword SxhkdModifier super
" syntax keyword SxhkdModifier hyper
" syntax keyword SxhkdModifier meta
" syntax keyword SxhkdModifier alt
" syntax keyword SxhkdModifier control
" syntax keyword SxhkdModifier mode_switch
" syntax keyword SxhkdModifier lock
" syntax keyword SxhkdModifier mod1
" syntax keyword SxhkdModifier mod2
" syntax keyword SxhkdModifier mod3
" syntax keyword SxhkdModifier mod4
" syntax keyword SxhkdModifier mod5
" syntax keyword SxhkdModifier any

" syntax keyword SxhkdNamedKey Return
" syntax keyword SxhkdNamedKey Escape
" syntax keyword SxhkdNamedKey grave
" syntax keyword SxhkdNamedKey Print
" syntax keyword SxhkdNamedKey comma
" syntax keyword SxhkdNamedKey period
" syntax keyword SxhkdNamedKey Tab
" syntax keyword SxhkdNamedKey space
" syntax keyword SxhkdNamedKey Up
" syntax keyword SxhkdNamedKey Down
" syntax keyword SxhkdNamedKey Left
" syntax keyword SxhkdNamedKey Right
" syntax keyword SxhkdNamedKey minus
" syntax keyword SxhkdNamedKey equal

" syntax match SxhkdSemicolon ';'
" syntax match SxhkdUnderline '_' contained
" syntax match SxhkdInvalidBrace '{[^\n}]*$'
" syntax region SxhkdBraceBlock matchgroup=SxhkdBrace start="{" end="}" keepend contains=SxhkdUnderline transparent
" syntax match SxhkdComment   '^#.*'
" syntax match SxhkdCommand '^\s\+.*' transparent


" highlight link SxhkdSemicolon Operator
" highlight link SxhkdBrace Delimiter
" highlight link SxhkdInvalidBrace Error
" highlight link SxhkdUnderline SpecialChar
" highlight link SxhkdComment   Comment
" highlight link SxhkdModifier  Keyword
" highlight link SxhkdNamedKey  Constant
" highlight link SxhkdOperator  Operator
