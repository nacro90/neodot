" colorscheme hashpunk

" Variables
" Ignore marked as done
let b:done_ignored = 0

" Sets
" Treat tags as a whole word
set iskeyword+=-
set iskeyword+=_
set iskeyword+=+

" Mappings
" Prepend date on every new line
nnoremap <buffer> o o<Cmd>call todo#txt#prepend_date()<CR> 
nnoremap <buffer> O O<Cmd>call todo#txt#prepend_date()<CR> 
inoremap <buffer> <CR> <CR><Cmd>call todo#txt#prepend_date()<CR> 
vnoremap <buffer> <CR> <Cmd>'<,'>normal \x<CR>
nmap <buffer> <CR> <Cmd>call todo#txt#mark_as_done()<CR><C-l>

nnoremap <buffer> <leader>v <Cmd>call orcan#todo#txt#ToggleDoneIgnore()<CR>

nnoremap <buffer> dp <Cmd>normal mp^daW`p4h<CR>

" Autocommands
augroup orcan_todo_txt
    autocmd!
    autocmd BufWritePre <buffer> silent! %substitute/\s\+$//
augroup end

