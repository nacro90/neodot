set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

set iskeyword+=_

" Autofolding disabled by default
set foldlevel=99
set foldmethod=indent

" Widely used textwidth value for python. Black uses it too.
" It becomes annoying
" set textwidth=88

" nnoremap <silent> <leader>l <Cmd>call orcan#python#AutoformatBlack()<CR>
nnoremap <leader>sr :w<bar>!python %<CR>

nnoremap <buffer> <leader><C-i> O__import__('ipdb').set_trace()<Esc>

set textwidth=0

setlocal indentkeys-=:
setlocal indentkeys-=<:>

abbreviate reutrn return
abbreviate reutnr return
