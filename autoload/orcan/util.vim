function orcan#util#Sudo(shcmd)
    let $p = inputsecret('[sudo] password for ' . $USER . ': ')
    let execstr = 'echo "' . $p . '" | sudo ' . a:shcmd
    let $p=''
endfunction
    

