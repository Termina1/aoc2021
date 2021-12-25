load 'jpm'

] data =. > ".@(('on';'1';'off';'0';'x';'';'y';'';'z';'';'=';'';'..';',';'-';'_')&stringreplace) each <"1 'm' fread 'day22/day22.txt'

intersect =. {{ ({.@[ u {:@]) -.@+. ({:@[ v {.@]) }}

NB. this helps us to check that left args coords (x) are within interval (y)
bounds =. ({.@] <: [) *. ({:@] >: [)
NB. we need this to create a partitioning of the original interval considering another interval. i.e (1 4) (2 3) creates paritioning (1 2, 2 3, 3 4)
sections =. <@([ _2&([\)@:sort@:, ,@:((0$0&[)@:])`([ (bounds~ # ]) ((+)&(_1 1)@] , (~: # ])))@.(> intersect <))

NB. (10 20) sections (21 30)
NB. (_29 23) sections (_36 _30)

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
checkbounds =. dyad define
  if. (({. x) = ({. y)) +. (({: x) = ({: y)) do.
    0
  elseif. ({.x) >: ({:y) do.
    1
  else.
    2
  end.
)
NB. merge 2 intervals x, y
mergepair =. [`(({.@] , {:@[))`({.@[ , {:@])@.checkbounds
NB. takes head, creates merge split than merges head with first intervals from merge split
mergestep =. ((({. <@(mergepair"1&>) {.@:}.) , 2&}.)^:(1&<@#)@:(>@{.) ({. ,~ }.)@, >@{:)@mergesplit
merge =. ({. mergestep }.)^:(1&<@#)^:((1&+)@#)

debug =. adverb define
  smoutput x;y
  z =. x u y
  smoutput x;y;'res';z
  z
)

NB. subtracts interval y from x
subtract =. merge@:rmifactor@:(-.@>@(*./@:(2&{"1)&.>) # ])@:(cubsplit)
add =. merge@:~.@:rmifactor@:(cubsplit~ , cubsplit)
NB. ((0 1) ,: (0 1)) add ((3 4) ,: (3 4))
NB. ((0 1) ,: (0 1)) add ((0 2) ,: (0 2))
NB. ((0 2) ,: (0 2)) add ((1 3) ,: (1 3))
NB. ((0 2) ,: (0 2)) add~ ((1 3) ,: (1 3))
NB. ((0 3) ,: (0 3)) subtract ((_2 4) ,: (_2 4))
NB. ((1 4) ,: (1 4)) subtract ((2 3) ,: (2 3))
NB. ((11 13) ,: (13 13)) subtract ((9 11) ,: (9 11))
NB. ((11 12), (10 13) ,: (11 12)) subtract ((9 11), (9 11) ,: (9 11))
NB. ((10 10) ,: (10 10)) add ((13 13) ,: (11 13))
merge ((<((0 1) ,: (0 1))), (<((0 2) ,: (0 2))))

NB. ] test =. (<((0 2) ,: (0 2)))
NB. ] testset=. (<(0 1 ,: 0 1)), ((<(3 4 ,: 3 4)))

on =. merge@:~.@:;@:(add&.>)
off =. merge@:~.@:;@:(subtract~&.>)
coords =. <@(_2&(]\)@}.)

] start =. coords {. data
] datatl =. }. data

filterempty =. (a:&~: # ])
step =. (coords@[ off ])`(coords@[ on ])@.({.@[)
calcubeson =. +/@:>@:((*/@:(1&+)@:(-~/"1))&.>)@:filterempty
calcubeson start
NB. calcubeson each <"1 (start (] F:. step) datatl)
$ (start (] F.. step) datatl)
