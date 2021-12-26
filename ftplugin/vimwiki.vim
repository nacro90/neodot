" Guides to simplyfy reading process
set textwidth=79
" set colorcolumn=81
set foldlevel=99

nmap <C-h> <Plug>VimwikiGoBackLink

" Remove unimparied bindings
silent! nunmap =op
silent! nunmap =o
silent! nunmap =p
silent! nunmap =P
