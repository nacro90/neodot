filetype indent on
set tabstop=4 "Specifies length of TAB character
set softtabstop=4 "Specifies how many spaces is TAB
set shiftwidth=4
set expandtab "Tabs becomes spaces
" setlocal colorcolumn=81
" Comment char with a preceeding space
set commentstring=;\ %s
" Folding with markers
set foldmethod=syntax
" Fold by default
set foldlevel=0

noremap <buffer><silent> { ?^\d<CR>
noremap <buffer><silent> } /^\d<CR>
nnoremap <leader>c <Cmd>call ledger#transaction_state_toggle(line('.'), '*!')<CR>
nnoremap <leader>e <Cmd>call ledger#entry()<CR>
nnoremap <buffer> <leader>m <Cmd>silent make\|redraw!\|cwindow<CR>


let g:ledger_fold_blanks = 1
let g:ledger_date_format = '%Y-%m-%d'
let g:ledger_use_location_list = 1

augroup orcan_ledger_start_bottom
    autocmd!
    autocmd VimEnter * normal G
augroup end

nnoremap <leader>l mm<Cmd>call search('; <++> Records')<CR>jgqG`m
