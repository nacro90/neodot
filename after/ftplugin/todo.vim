" Set done ignore according to corresponding variable
call orcan#todo#txt#SetDoneIgnore(b:done_ignored)

nnoremap <buffer> <leader>d <Cmd>call todo#txt#prioritize_add("D")<CR>
nnoremap <buffer> <leader>c <Cmd>call todo#txt#prioritize_add("C")<CR>
nnoremap <buffer> <leader>b <Cmd>call todo#txt#prioritize_add("B")<CR>
nnoremap <buffer> <leader>a <Cmd>call todo#txt#prioritize_add("A")<CR>

nnoremap <buffer> >> <Cmd>.call todo#txt#prioritize_decrease()<CR>
vnoremap <buffer> > <Cmd>call todo#txt#prioritize_decrease()<CR>
nnoremap <buffer> << <Cmd>.call todo#txt#prioritize_increase()<CR>
vnoremap <buffer> < <Cmd>call todo#txt#prioritize_increase()<CR>

nnoremap <buffer> <leader>z <Cmd>normal A @cancelled<CR>
nnoremap <buffer> <leader>ss <Cmd>sort<CR>
