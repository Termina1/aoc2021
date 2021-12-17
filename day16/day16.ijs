load 'jforc.ijs'

data =. {. 'm' fread 'day16/day16.txt'
tobin =. ,/@}:@(#:@:".@:('16b',"1])@:tolower@(_2]\]))@(,&'FF') NB. FF for aligning to byte
gs =. ;@(2&{)
gp =. ;@(0&{)
gr =. ;@(1&{)
c =. {{ (gp y); (x }. (gr y)); ((gs y) u (gr y)) }}
ct =. {{ ((x u (gs (v y))) `: 6) y }}
m =.  {{ (}: , <@(gr u gs)) }}
mp =. {{ (gp <@u gs) , }. }}
mpc =. {{ ((;@{.@[ <@u ]) , }.@[) mp }}
ev =. , mpc
t =. {{ m&(#.@:(m{.]) c) }}
ta =. {{ m&(([ , m{.]) c) }}
d =. {{ m&([ c) }}
r =. {{ (}: (u y)), {: y }}
l =. {{ y [ smoutput x;(y) }}
e =. ((a:)&[ ; (] ; (0$0)&[))
s =. {~ ct ]
st =. ({~ ct (1 t))
push =. ((a: , [) mp)@(0 t)
pop =. (((;@{.@[ <@, >@(1{])@[) , 2&}.@[) mp)
g =. {{ pop@u@push }}

literal =. (4 ta)@(1 d)`(literal@(4 ta)@(1 d))&st
subpackets =. ,/@((((packet r)^:(#@gr@] > gs@])@(,/)^:_)@((#@[ - ]) m)@(15 t))`(,/@packet^:(gs)@(11 t))&s@(1 t))
sum =. (+/@[ mpc)@subpackets
prod =. (*/@[ mpc)@subpackets
min =. (<./@[ mpc)@subpackets
max =. (>./@[ mpc)@subpackets
gt =. (</@[ mpc)@subpackets
lt =. (>/@[ mpc)@subpackets
eq =. (=/@[ mpc)@subpackets
lit =. (ev@(#.@] m)@literal)

packet =. (sum g)`(prod g)`(min g)`(max g)`(lit g)`(gt g)`(lt g)`(eq g)&s@(3 t)@(3 t)
Ts '] part2 =. gp (packet (e (tobin data)))'
