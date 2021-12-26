" Reformat python file with black
function! orcan#python#AutoformatBlack()
    silent write
    silent !black %
    silent !isort %
    edit
endfunction

