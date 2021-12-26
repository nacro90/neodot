let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd ~/prod/ssat/ssat-api
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +70 san.rest
badd +1 __REST_response__
badd +138 src/service/__init__.py
badd +439 src/provider/san/mapper.py
badd +910 /usr/share/nvim/runtime/doc/pattern.txt
badd +4 src/database/__init__.py
badd +112 ~/prod/ssat/ssat-api/src/provider/san/__init__.py
badd +471 src/service/model.py
badd +408 src/api/model.py
badd +176 src/api/mapper.py
badd +7 ~/prod/ssat/ssat-api/src/database/schema.py
badd +1 ~/prod/ssat/ssat-api/src/database/mapper.py
badd +90 src/api/router/bookings.py
badd +68 src/api/router/flights.py
badd +14 ~/prod/ssat/ssat-api/src/provider/san/endpoint.py
badd +70 ~/prod/ssat/ssat-api/src/provider/san/sessionmanager.py
badd +6 ~/prod/ssat/ssat-api/src/provider/auth.py
badd +2 ~/prod/ssat/ssat-api/src/service/error.py
badd +30 ~/prod/ssat/ssat-api/src/api/__init__.py
badd +21 ~/prod/ssat/ssat-api/src/api/error.py
badd +24 ~/prod/ssat/ssat-api/src/service/validation.py
badd +16 api.rest
badd +25 src/util.py
badd +174 ~/.cache/pypoetry/virtualenvs/ssat-api-2vfz8tGB-py3.8/lib/python3.8/site-packages/starlette/requests.py
badd +0 ~/.config/nvim/lua/plugins.lua
argglobal
%argdel
set stal=2
tabnew
tabrewind
edit ~/.config/nvim/lua/plugins.lua
set splitbelow splitright
wincmd t
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
argglobal
balt ~/prod/ssat/ssat-api/src/database/mapper.py
setlocal fdm=marker
setlocal fde=v:lua.manillua.foldexpr(v:lnum)
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=99
setlocal fml=1
setlocal fdn=20
setlocal fen
5
normal! zo
218
normal! zo
274
normal! zo
586
normal! zo
let s:l = 864 - ((18 * winheight(0) + 18) / 37)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 864
normal! 056|
tabnext
edit api.rest
set splitbelow splitright
wincmd t
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
argglobal
balt src/database/__init__.py
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=99
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let &fdl = &fdl
let s:l = 16 - ((15 * winheight(0) + 18) / 37)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 16
normal! 021|
tabnext 1
set stal=1
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0&& getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20 winminheight=1 winminwidth=1 shortmess=finxtToOFmwlAcI
let s:sx = expand("<sfile>:p:r")."x.vim"
if filereadable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &g:so = s:so_save | let &g:siso = s:siso_save
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
