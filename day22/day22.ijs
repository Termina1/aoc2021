] data =. > ".@(('on';'1';'off';'0';'x';'';'y';'';'z';'';'=';'';'..';',';'-';'_')&stringreplace) each <"1 'm' fread 'day22/day22.txt'

intersect =. {{ ({.@[ u {:@]) -.@+. ({:@[ v {.@]) }}

NB. this helps us to check that left args coords (x) are within interval (y)
bounds =. ({.@] <: [) *. ({:@] >: [)
NB. we need this to create a partitioning of the original interval considering another interval. i.e (1 4) (2 3) creates paritioning (1 2, 2 3, 3 4)
sections =. <@([ _2&([\)@:sort@:, ,@:((0$0&[)@:])`([ (bounds~ # ]) ((+)&(_1 1)@] , (~: # ])))@.(> intersect <))

NB. this ads intersections factor for partitioning, so we could figure out which dims of each partitioning intersects with right interval
axisintervals =. (] (] ([ ([ ,"1 |:@,:@]) ])&.> (<"1@[ (> intersect <)"1&.> ])) sections"1)

NB. combines intervals for each axis into hypercube
cubsplit =. ,@((,&>)&.>@{@(<"1&.>@axisintervals))
NB. removes intersection factor
rmifactor =. (}:"1)&.>

NB. checks whether we can connect 2 intervals side by side, or they are the same
connectscore =. (*./@:= +. ([ (11&*)@+./@:(1&>:)@:|@:- |.@]))

checkscore =. (# (((10&+)@[ = ]) +. =) +/)
NB. x is interval we want to merge to some other interval in y. splits y in 2 parts: intervals that can be connected with x and those that can not
mergesplit =. ([ ((<@[ ,&.> {.@]) , {:@]) ((<@[ ;@:((checkscore)&.>)@:(connectscore"1&>/ each)@{@;~ ]) (([ # ]) ; <@(-.@[ # ])) ]))
NB. if intervals are the same 0, if x is on the right 1, else 2
checkbounds =. {{ if. (({. x) = ({. y)) +. (({: x) = ({: y)) do. 0 elseif. ({.x) >: ({:y) do. 1 else. 2 end. }}
NB. merge 2 intervals x, y
mergepair =. [`(({.@] , {:@[))`({.@[ , {:@])@.checkbounds
NB. takes head, creates merge split than merges head with first intervals from merge split
mergestep =. ((({. <@(mergepair"1&>) {.@:}.) , 2&}.)^:(1&<@#)@:(>@{.) ({. ,~ }.)@, >@{:)@mergesplit
merge =. ({. mergestep }.)^:(1&<@#)^:((1&+)@#)

NB. subtracts x from y
subtract =. merge@:rmifactor@:(-.@>@(*./@:(2&{"1)&.>) # ])@:(cubsplit)

NB. given cuboid x and set of on cuboids y, turns off all cuboids in y that are also in x
off =. ;@:(subtract~&.>)
NB. the reverse operation of off
on =. ((] F.. off) , ])
coords =. <@(_2&(]\)@}.)

] start =. coords {. data
] datatl =. }. data

filterempty =. (a:&~: # ])
step =. (coords@[ off ])`(coords@[ on ])@.({.@[)
calcubeson =. +/@:>@:((*/@:(1&+)@:(-~/"1))&.>)@:filterempty

debugdata =. ((50&>: *./"1@:*. _50&<:) # ]) datatl
] part1 =. calcubeson (start (] F.. step) debugdata)
] part2 =. calcubeson (start (] F.. step) datatl)
