" Linux and BSD distributions use groff as their default text processing
" package.  In order to activate the extra syntax highlighting features for
" groff, add the following option to your start-up files
"
let b:nroff_is_groff = 1

" 1. Do not leave empty spaces at the end of lines. 

" 2. Leave one space and one space only after an end-of-sentence period,
   " exclamation mark, etc.

" 3. For reasons stated below, it is best to follow all period marks with a
   " carriage return.

" The reason behind these unusual tips is that g/n/troff have a line breaking
" algorithm that can be easily upset if you don't follow the rules given above.

" Unlike TeX, troff fills text line-by-line, not paragraph-by-paragraph and,
" furthermore, it does not have a concept of glue or stretch, all horizontal and
" vertical space input will be output as is.

" Therefore, you should be careful about not using more space between sentences
" than you intend to have in your final document.  For this reason, the common
" practice is to insert a carriage return immediately after all punctuation
" marks.  If you want to have 'even' text in your final processed output, you
" need to maintain regular spacing in the input text.  To mark both trailing
" spaces and two or more spaces after a punctuation as an error, use: >
"
let nroff_space_errors = 1

" Auto insert commonly used unicode characters {{{
" When groff escapes have been typed
" inoremap <buffer> <nowait> ç \[,c]
" inoremap <buffer> <nowait> Ç \[,C]
" inoremap <buffer> <nowait> ı \[.i]
" inoremap <buffer> <nowait> İ \[u0130]
" inoremap <buffer> <nowait> ö \[:o]
" inoremap <buffer> <nowait> Ö \[:O]
" inoremap <buffer> <nowait> ü \[:u]
" inoremap <buffer> <nowait> Ü \[:U]
" inoremap <buffer> <nowait> ğ \[u011F]
" inoremap <buffer> <nowait> Ğ \[u011E]
" inoremap <buffer> <nowait> ş \[u015F]
" inoremap <buffer> <nowait> Ş \[u015E]
" }}}

" Hide conceals that don't have conceal character
setlocal conceallevel=2
" In groff there is no need to track lines because of the shortiness
setlocal nocursorline
" It's a classic but I dont like it
" setlocal textwidth=79
" Typesetting does not bear with softwraps!
setlocal nowrap

" Trailing whitespaces in lines can be problematic in groff
autocmd BufWritePre *.roff %substitute/\s\+$//e
" TODO Make the preview function more useful
" autocmd BufWritePost *.roff make txt

