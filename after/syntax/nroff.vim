" Match and conceal unicodes
syntax match nroffSpecialChar "\\\[,C\]" conceal cchar=Ç
syntax match nroffSpecialChar "\\\[,c\]" conceal cchar=ç
syntax match nroffSpecialChar "\\\[\.i\]" conceal cchar=ı
syntax match nroffSpecialChar "\\\[u0130\]" conceal cchar=İ
syntax match nroffSpecialChar "\\\[:o\]" conceal cchar=ö
syntax match nroffSpecialChar "\\\[:O\]" conceal cchar=Ö
syntax match nroffSpecialChar "\\\[:u\]" conceal cchar=ü
syntax match nroffSpecialChar "\\\[:U\]" conceal cchar=Ü
syntax match nroffSpecialChar "\\\[u011[Ff]\]" conceal cchar=ğ
syntax match nroffSpecialChar "\\\[u011[Ee]\]" conceal cchar=Ğ
syntax match nroffSpecialChar "\\\[u015[Ff]\]" conceal cchar=ş
syntax match nroffSpecialChar "\\\[u015[Ee]\]" conceal cchar=Ş

syntax match nroffSpecialChar "\\(Do" conceal cchar=$
syntax match nroffSpecialChar "\\(Eu" conceal cchar=€
syntax match nroffSpecialChar "\\(Po" conceal cchar=£
syntax match nroffSpecialChar "\\(aq" conceal cchar='
syntax match nroffSpecialChar "\\(bu" conceal cchar=•
syntax match nroffSpecialChar "\\(co" conceal cchar=©
syntax match nroffSpecialChar "\\(cq" conceal cchar=’
syntax match nroffSpecialChar "\\(ct" conceal cchar=¢
syntax match nroffSpecialChar "\\(dd" conceal cchar=‡
syntax match nroffSpecialChar "\\(de" conceal cchar=°
syntax match nroffSpecialChar "\\(dg" conceal cchar=†
syntax match nroffSpecialChar "\\(dq" conceal cchar="
syntax match nroffSpecialChar "\\(em" conceal cchar=—
syntax match nroffSpecialChar "\\(en" conceal cchar=–
syntax match nroffSpecialChar "\\(hy" conceal cchar=‐
syntax match nroffSpecialChar "\\(lq" conceal cchar=“
syntax match nroffSpecialChar "\\(oq" conceal cchar=‘
syntax match nroffSpecialChar "\\(rg" conceal cchar=®
syntax match nroffSpecialChar "\\(rq" conceal cchar=”
syntax match nroffSpecialChar "\\(rs" conceal cchar=\
syntax match nroffSpecialChar "\\(sc" conceal cchar=§
syntax match nroffSpecialChar "\\(tm" conceal cchar=™
syntax match nroffSpecialChar "\\(ul" conceal cchar=_
syntax match nroffSpecialChar "\\(Identical" conceal cchar=≡
syntax match nroffSpecialChar "\\(Largerentical" conceal cchar=≥
syntax match nroffSpecialChar "\\(Lessrgerentical" conceal cchar=≤
syntax match nroffSpecialChar "\\(Notssrgerentical" conceal cchar=≠
syntax match nroffSpecialChar "\\(Righttssrgerentical" conceal cchar=→
syntax match nroffSpecialChar "\\(Leftghttssrgerentical" conceal cchar=←
syntax match nroffSpecialChar "\\(Plusftghttssrgerentical" conceal cchar=±

syntax match nroffIgnore "\\&" conceal

