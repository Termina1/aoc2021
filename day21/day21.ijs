update =. {{ (([ u (n&{)@:]) n} ]) }}
cartesian =. {@(,&<)

comb=: 4 : 0
 k=. i.>:d=.y-x
 z=. (d$<i.0 0),<i.1 0
 for. i.x do. z=. k ,.&.> ,&.>/\. >:&.> z end.
 ; z
)
$ 3 comb 9

dirackdice =. +/"1 ~. (3 comb 9) { (1 2 3 1 2 3 1 2 3)
dirackdicecomp =. ~.dirackdice
dirackmap =. ((i.(# dirackdicecomp)) #~ >@(#&.>@~.@:((I.&.>)@:<"1@:e.))) dirackdice

positions =. (<"0@(0&,))&.> ".@(('Player';'';' starting position:';'')&stringreplace) each <"1 'm' fread 'day21/day21.txt'

lift =. (}: , ;@:{:)
split =. (<@}: ,/@:((;@{. , }.)&.>)@:cartesian ;@{:)
games =. 0{]
state =. 2{]
dice =. 1{]

undermodulo =. {{ ([ (1&+)@:(n&|)@:u (-&1)@:]) }}
updatepos =. 2 ((10 (+ undermodulo))&.> update)
updatescore =.(0 (((2&{)@:[ (+)&.> ]) update))
stop =. {{ 0&<@:+/@(x&<:@:;)@:((;@:(0&{))&.>) y }}
round =. (}.@:] cartesian ([ (updatescore@:updatepos)&.> {.@:]))
droll =. (3&(100 (+ undermodulo)))&.>
play =. {{ ((3&incrgames , v@:dice) , <@((u@:[ round ])&>/)@}.) }}
incrgames =. ([ <@+ ;@games@])
looserscore =. <./@:(>@((0{])&.>)@;^:2)
haswon =. ((;@(;@(1{])&.>@:]) I.@:= [) = </@:(>@(>@(0{])&.>)))

quantumplay =. {{ +/ dirackmap {  > ((1&haswon , 2&haswon)@;@state)`(quantumplayM)@.(-.@(21&stop)@:>@:state) each split@([ play [) y }}
quantumplayM =. quantumplay M.

] part1 =. (looserscore@state * ;@games) (lift@(+/ play droll))^:(-.@(1000&stop)@:>@:state)^:_ (0;(1 2 3);<positions)
] part2 =. >./ quantumplayM (0;dirackdicecomp;<positions)

