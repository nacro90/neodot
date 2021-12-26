
" }}}

" Utils: {{{

" }}}


" Variables: {{{

" let $FZF_DEFAULT_OPTS = "--color=16 --info=inline --marker='* ' --bind=change:top --bind=ctrl-b:page-up --bind=ctrl-f:page-down --bind=ctrl-u:half-page-up --bind=ctrl-d:half-page-down"


" Themes & colors: {{{


" let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
" let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"

" }}}



if (has('nvim'))
    tnoremap <C-w>m <Cmd>tabedit<CR>
    tnoremap <C-w><C-m> <Cmd>tabedit<CR>
    tnoremap <C-w>, <Cmd>tabprevious<CR>
    tnoremap <C-w><C-,> <Cmd>tabprevious<CR>
    tnoremap <C-w>. <Cmd>tabnext<CR>
    tnoremap <C-w><C-.> <Cmd>tabnext<CR>
    tnoremap <C-w>q <Cmd>wincmd q<CR>
    tnoremap <C-w><C-q> <Cmd>wincmd q<CR>
    tnoremap <C-w>c <Cmd>wincmd c<CR>
    tnoremap <C-w><C-c> <Cmd>wincmd c<CR>
    tnoremap <C-w>h <Cmd>wincmd h<CR>
    tnoremap <C-w><C-h> <Cmd>wincmd h<CR>
    tnoremap <C-w>j <Cmd>wincmd j<CR>
    tnoremap <C-w><C-j> <Cmd>wincmd j<CR>
    tnoremap <C-w>k <Cmd>wincmd k<CR>
    tnoremap <C-w><C-k> <Cmd>wincmd k<CR>
    tnoremap <C-w>l <Cmd>wincmd l<CR>
    tnoremap <C-w><C-l> <Cmd>wincmd l<CR>

    tnoremap <C-l> <Cmd>nohlsearch<CR>
    tnoremap <expr> <M-r> '<C-\><C-N>"' . nr2char(getchar()) . 'pi'
endif

" }}}


" " Deoplete: {{{
" let g:deoplete#enable_at_startup = 1

" call deoplete#custom#source('ultisnips', 'rank', 10000)

" function g:Multiple_cursors_before()
"     call deoplete#custom#buffer_option('auto_complete', v:false)
" endfunction
" function g:Multiple_cursors_after()
"     call deoplete#custom#buffer_option('auto_complete', v:true)
" endfunction



" call deoplete#custom#option('skip_chars': [])


" }}}


" highlight HighlightedyankRegion cterm=reverse gui=reverse

" }}}

" }}}


" DEL key {{{


" Remove leading whitespaces {{{

nnoremap <leader>mw <Cmd><CR>

" }}}

" Syntastic {{{


" }}}

" NrrwRgn: {{{

xmap gn <Plug>NrrwrgnDo
nmap gn <Plug>NrrwrgnDo

" }}}

    
" Turkish keyboard flaws
nnoremap ı i

" Ctags: {{{
nnoremap <leader>T <Cmd>ctags -R .<CR>
"}}}

" Enough emacsy window combination. {{{
" I have an emacsy habit...
" nnoremap <C-h> <Cmd>wincmd h<CR>
" nnoremap <C-j> <Cmd>wincmd j<CR>
" nnoremap <C-k> <Cmd>wincmd k<CR>
" nnoremap <C-l> <Cmd>wincmd l<CR>
" }}}

" Lf: {{{

nnoremap <leader>f <Cmd>Lf<CR>
nnoremap <leader>F <Cmd>LfWorkingDirectory<CR>

" }}}

" Deoplete: {{{

inoremap <expr> <C-x><C-x> deoplete#manual_complete()

" }}}
" call se
nnoremap <leader>ss <Cmd>LanguageClientToggle<CR>

" C-w is life: {{{

nnoremap <C-w>. <Cmd>tabnext<CR>
nnoremap <C-w>, <Cmd>tabprevious<CR>
nnoremap <C-w><C-.> <Cmd>tabnext<CR>
nnoremap <C-w><C-,> <Cmd>tabprevious<CR>

nnoremap <C-w>m <Cmd>tabedit<CR>
nnoremap <C-w><C-m> <Cmd>tabedit<CR>
" }}}

" Nvim configuration: {{{
" function! EditVimrc()

nnoremap <leader>ev <Cmd>vsplit $MYVIMRC<CR>
nnoremap <leader>sv <Cmd>source $MYVIMRC<CR>
" }}}

" Fast resizing: {{{
noremap <C-w><lt> 5<C-w><lt>
noremap <C-w>> 5<C-w>>
noremap <C-w>+ 3<C-w>+
noremap <C-w>- 3<C-w>-
"}}}

" Append new line: {{{
" TODO inoremap <silent> <M-m>
" }}}

" Edit personal main todo file: {{{
"
function EditOptionalFile(file)
    if exists(a:file)
        execute "edit " . a:file
    else
        echoerr "File " . a:file . " does not exists!"
    endif
endfunction

nnoremap <leader>et <Cmd>call EditOptionalFile($TODO)<CR>
" }}}

" Edit personal calendar file: {{{
nnoremap <leader>ec <Cmd>call EditOptionalFile($CALENDAR)<CR>
" }}}

" Edit personal quick notes file: {{{
nnoremap <leader>eq <Cmd>call EditOptionalFile($QUICK)<CR>
" }}}

" Edit personal wiki notes file: {{{
nnoremap <leader>ew <Cmd>call EditOptionalFile($WIKI)<CR>
" }}}

" Terminal: {{{ TODO: Make use of it
" Focuses the terminal window by default
" nnoremap <leader>t <Cmd>10split term://zsh<CR>
" }}}

" Kill current buffer: {{{
" If there is unsaved changes then display a prompt
function IKillBuffer()
    if &modified
        if confirm("Buffer has been modified! Kill the buffer?")
            Bclose
        endif
    else
        Bclose
    endif
endfunction

nnoremap <leader>k <Cmd>call IKillBuffer()<CR>
" }}}


" Replace with register: {{{
" }}}

" Colorizer
" nnoremap <leader>v <Cmd>ColorizerToggle<CR>

" Easy configure the corresponding filetype: {{{
function! s:ConfigureFiletype(folder, filetype)

    function! CreateExecuteScript(ft) closure
        let l:execString = printf('%s/nvim/%s/%s.vim', $XDG_CONFIG_HOME, a:folder, a:ft)
        return join(['vsplit', fnameescape(l:execString)], ' ')
    endfunction

    if empty(a:filetype)
        let l:filetype = input({
                    \ 'prompt': printf("Which filetype do you want to configure for %s?\n", a:folder),
                    \ 'default': &filetype,
                    \ 'cancelreturn': -1
                    \ })
        if l:filetype == -1 || (empty(l:filetype) && empty(&l:filetype))
            return
        elseif empty(filetype)
            execute CreateExecuteScript(&l:filetype)
        else
            execute CreateExecuteScript(l:filetype)
        endif
    else
        execute CreateExecuteScript(a:filetype)
    endif
endfunction

command! ConfigureFtplugin :call s:ConfigureFiletype('ftplugin', '')
nnoremap <leader>ef <Cmd>ConfigureFtplugin<CR>
command! ConfigureSyntax :call s:ConfigureFiletype('after/syntax', '')
nnoremap <leader>es <Cmd>ConfigureSyntax<CR>
" }}}


" Easy Expansion of the Active File Directory from Practical Vim: {{{
function ExpandPercentageIfInCommand()
    if getcmdtype() == ':'
        return expand('%:h') . '/'
    else
        return '%%'
    endif
endfunction
cnoremap <expr> %% ExpandPercentageIfInCommand()
" }}}

" Clear search highlighting before redraw: {{{

nnoremap <silent> <C-q> <Cmd>nohlsearch<bar>redraw<CR>
" Clear search higlighting in insert mode and command-line mode
noremap! <silent> <C-q> <Cmd>nohlsearch<bar>redraw<CR>

" }}}

" Pad current line with new lines
nnoremap <M-o> m0o<ESC>kO<ESC>`0
inoremap <M-o> <ESC>m0o<ESC>kO<ESC>`0i

" Yank with 'Y' should be like 'D' or 'C'
nnoremap Y y$

" }}}

" Vim workspace plugin
" nnoremap <leader>s :ToggleWorkspace<CR>

" GitGutter: {{{

" Don't need to assign keys to these
" nnoremap <leader>ggl :GitGutterLineHighlightsToggle<CR>
" nnoremap <leader>ggn :GitGutterLineNrHighlightsToggle<CR>
" nnoremap <leader>ggb :GitGutterBufferToggle<CR>
" nnoremap <leader>ggg :GitGutterToggle<CR>
" nnoremap <leader>ggs :GitGutterSignsToggle<CR>

nnoremap ]h <Cmd>GitGutterNextHunk<CR>
nnoremap [h <Cmd>GitGutterPrevHunk<CR>

nnoremap ga. <Cmd>GitGutterStageHunk<CR>
nnoremap gr. <Cmd>GitGutterUndoHunk<CR>

" }}}

" Fugitive: {{{
"
" I am using command line more...
"
" Git status
nnoremap <leader>gs <Cmd>Git<CR>
" Push
nnoremap <leader>gp :Git push<space>
" Vertical diff split
nnoremap <leader>gd <Cmd>Gvdiffsplit<CR>
" Revert
nnoremap <leader>gr% <Cmd>Gread<CR>
" Write / stage
nnoremap <leader>ga% <Cmd>Gwrite<CR>
nnoremap <leader>gaa <Cmd>Git add --all<CR>
" Merge
nnoremap <leader>gm :Git merge<space>
" Log
nnoremap <leader>gl <Cmd>vertical Git log<CR>
" Blame
nnoremap <leader>gbl <Cmd>Git blame<CR>
" Checkout
nnoremap <leader>gco :Git checkout<space>
" G-edit - Show HEAD version of the file

" on current buffer
nnoremap <leader>goo <Cmd>Gedit<CR>
" on vertical split
nnoremap <leader>gov <Cmd>Gvsplit<CR>
" on horizontal split
nnoremap <leader>gos <Cmd>Gsplit<CR>
" on new tab
nnoremap <leader>got <Cmd>Gtabedit<CR>
" on popup
nnoremap <leader>gop <Cmd>Gpedit<CR>


" }}}

" Display foldlevel
nmap z<C-x> <Cmd>set foldlevel?<CR>

" EasyAlign: {{{

" }}}

" {move} -> g{move} {{{
function! ScreenMovement(movement)
    if &wrap
        return "g" . a:movement
    else
        return a:movement
    endif
endfunction
onoremap <silent> <expr> j ScreenMovement("j")
onoremap <silent> <expr> k ScreenMovement("k")
onoremap <silent> <expr> 0 ScreenMovement("0")
onoremap <silent> <expr> ^ ScreenMovement("^")
onoremap <silent> <expr> $ ScreenMovement("$")
nnoremap <silent> <expr> j ScreenMovement("j")
nnoremap <silent> <expr> k ScreenMovement("k")
nnoremap <silent> <expr> 0 ScreenMovement("0")
nnoremap <silent> <expr> ^ ScreenMovement("^")
nnoremap <silent> <expr> $ ScreenMovement("$")
" }}}

"}}}


" Autocommands: {{{

" " Auto View: {{{

" let g:skipview_files = [
            " \ '[EXAMPLE PLUGIN BUFFER]'
            " \ ]
" function! MakeViewCheck()
    " if has('quickfix') && &buftype =~ 'nofile'
        " " Buffer is marked as not a file
        " return 0
    " endif
    " if empty(glob(expand('%:p')))
        " " File does not exist on disk
        " return 0
    " endif
    " if len($TEMP) && expand('%:p:h') == $TEMP
        " " We're in a temp dir
        " return 0
    " endif
    " if len($TMP) && expand('%:p:h') == $TMP
        " " Also in temp dir
        " return 0
    " endif
    " if index(g:skipview_files, expand('%')) >= 0
        " " File is in skip list
        " return 0
    " endif
    " return 1
" endfunction
" augroup AutoView
    " autocmd!
    " " Autosave & Load Views.
    " autocmd BufWritePost,BufLeave,WinLeave ?* if MakeViewCheck() | silent! mkview | endif
    " autocmd BufWinEnter ?* if MakeViewCheck() | silent! loadview | endif
" augroup end

" " }}}

" Terminal auto insert: {{{

augroup orcan_init_vim_terminal
    autocmd!
    " Start insert when swithing to a terminal
    autocmd BufWinEnter,WinEnter term://* startinsert
augroup end

" }}}

" Indent Guides Terminal Toggle: {{{

" }}}

" Autoclose omni completion preview window: {{{
" If you prefer the Omni-Completion tip window to close when a selection is
" made, these lines close it on movement in insert mode or when leaving
" insert mode

augroup orcan_pum_visible_pclose
    autocmd InsertLeave * if pumvisible() == 0|pclose|endif
augroup END

" }}}

" Highlighting: {{{
function s:ColorschemeCorrections()
    highlight! link IndentGuidesOdd Folded
    highlight! link IndentGuidesEven Folded
    highlight! link Conceal Visual
    highlight! link MatchParen WildMenu
    highlight! link Todo SpecialComment
    highlight! link VertSplit Comment

    " Colorscheme specific corrections: {{{

    " }}}
 
    " }}}
endfunction

call s:ColorschemeCorrections()

augroup orcan_init_vim_colorscheme
    autocmd!
    autocmd VimEnter,ColorScheme * call s:ColorschemeCorrections()
augroup end

" }}}
" vim: fdm=marker ft=vim
