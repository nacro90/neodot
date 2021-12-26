" Make tabs exists like Makefile
set noexpandtab
set tabstop=2

if exists('g:NERDCustomDelimiters')
    let g:NERDCustomDelimiters.sxhkdrc = { 'left': '#' }
else
    let g:NERDCustomDelimiters = { 'sxhkdrc': { 'left': '#' } }
endif


