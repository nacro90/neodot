setlocal autoindent
" setlocal nonumber "No line numbers
setlocal shiftwidth=2
setlocal tabstop=2
setlocal expandtab
setlocal conceallevel=0
" Easy formatting while typing
setlocal textwidth=80
" No fold by default
" set colorcolumn=81
setlocal nofoldenable
" Enable spellcheck, which is default
setlocal nospell
setlocal spelllang=en,tr
" Close no folds
setlocal foldlevel=99


set iskeyword+=-

" set list "Display EOL's
" set listchars=eol:¬
" Enable the soft wrap
" set wrap
" Soft wrap by spaces, don't cut word
set linebreak


"t -> Autoformat while typing
"l ->
"n -> Respect list indentation
"q -> Autoformat html comments
"r -> Format insert new lines with <Enter>
" set formatoptions=tlnqr

" Mappings
" autocmd! BufWritePre *.md,*.mkd,*.markdown substitute

" Mark as done
" TODO Enhance
nnoremap <buffer> <leader>x <Cmd>normal! 0f[lrX<CR>

nnoremap <buffer> <CR> <Plug>Markdown_OpenUrlUnderCursor
