function orcan#init#LanguageClientStart()

    if !has_key(g:LanguageClient_serverCommands, &filetype)
        echoerr 'g:LanguageClient_serverCommands has no ''' . &filetype . ''' key'
        return
    endif

    LanguageClientStart

    let g:language_client_started = 1

    function! LanguageClientInfoRequest()
        call LanguageClient#textDocument_hover()
        call LanguageClient#textDocument_signatureHelp()
    endfunction

    function! LanguageClientCursorHold()
        call LanguageClient#textDocument_documentHighlight()
    endfunction

    nnoremap <silent> <C-k> <Cmd>call LanguageClientInfoRequest()<CR>
    inoremap <silent> <C-K> <Cmd>call LanguageClient#explainErrorAtPoint()<CR>
    nnoremap <silent> <C-]> <Cmd>call LanguageClient#textDocument_definition()<CR>
    nnoremap <silent> g<C-]> <Cmd>call LanguageClient#textDocument_typeDefinition()<CR>
    nnoremap <silent> <C-j> <Cmd>call LanguageClient#textDocument_codeAction()<CR>
    nnoremap <silent> g] <Cmd>call LanguageClient#textDocument_references()<CR>
    nnoremap <silent> <C-/> <Cmd>call LanguageClient#textDocument_rename()<CR>
    nnoremap <silent> <C-l> <Cmd>call LanguageClient#clearDocumentHighlight()\|nohlsearch\|redraw<CR>

    augroup language_client_autocmds
        autocmd!
        " autocmd CursorHold <buffer> silent! call s:LanguageClientCursorHold()
    augroup END

    set formatexpr=LanguageClient#textDocument_rangeFormatting_sync()

    echom 'Language client started'

endfunction

function orcan#init#LanguageClientStop()

    if !exists('g:language_client_started') || g:language_client_started == 0
        echoerr 'Language client is not running'
        return
    endif

    autocmd! language_client_autocmds

    nunmap <C-k>
    nunmap <C-M-k>
    nunmap <C-]>
    nunmap g]
    nunmap g<C-]>
    nunmap <C-;> 
    nunmap <C-/>
    nnoremap <C-l> <Cmd>nohlsearch\|redraw<CR>

    set formatexpr=

    LanguageClientStop

    let g:language_client_started = 0

    echom 'Language client stopped'

endfunction

function orcan#init#LanguageClientToggle()
    if !exists('g:language_client_started') || g:language_client_started == 0
        call orcan#init#LanguageClientStart()
    else
        call orcan#init#LanguageClientStop()
    endif
endfunction
