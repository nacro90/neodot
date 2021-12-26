" Ignore the lines that marked as 'done' using Ignore highlighting class
function! orcan#todo#txt#SetDoneIgnore(ignored)
    if a:ignored
        highlight! link TodoDone Ignore
    else
        highlight! link TodoDone Comment
    endif
    let b:done_ignored = a:ignored
endfunction

function! orcan#todo#txt#ToggleDoneIgnore()
    call orcan#todo#txt#SetDoneIgnore(!b:done_ignored)
endfunction

function! orcan#todo#txt#SmartSort()
    let l:current_line = getline('.')
    let l:current_column_index = col('.')
    sort
    " Start searching from top
    call cursor(0, 0)
    call search(l:current_line)
    call cursor(line('.'), l:current_column_index)
endfunction


