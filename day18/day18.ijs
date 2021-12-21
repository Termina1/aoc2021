load 'jpm'

data =. ".@(('[';'(<';']';')';',';'),(<')&stringreplace) each <"1 ('m' fread 'day18/day18.txt')
parse =. {{ _2 ]\ x (,/@:,)`((1&+)@[ ;@:($: each) ])@.(('boxed'&-:)@datatype@]) y }}
nums =. 0&parse each data

hs =. (10&<:)@(1&{)
he =. (5&=)@:(0&{)
hr =. I.@(he"1 ]`[@.(0&<@#@I.@[) hs"1)
g =. ((0&<:)@[ *. ([ < #@]))
gz =. 0&<@#
incr =. {{ ((0&{ , (m&+)@(1&{)) (x { y)) x } y }}
re =. dyad define
  left =. y { x
  right =. (y + 1) { x
  z =. (y - 1) ((1{left) incr)^:g x
  z =. (y + 2) ((1{right) incr)^:g z
  z =. (4 0) y } z
  is =. (i.(#z)) (~: # [) (y + 1)
  is { z
)
spv =. (1&+)`(%&2)@.(i.@#)
sp =. (_2&([\))@(<.@spv , >.@spv)@{
div =. {{ (u@[ (0&{.@]`v@.g) ]) }}
rs =. {{ x (((] div {.) , sp) , (1&+ div }.))~ y }}
reduce =. ([`([ rs`re@.(he@:{~) {.@])@.(0&<@#@]) hr)
sum =. reduce^:_@:((1 0)&+"1)@:,&.>

deleteadj =. ((1&+ div {.) , (2&+ div }.))
replaceadjacent =. {{ (inds - (i.#inds)) ([ F.. deleteadj)~ vs inds } x [ (vs =. |: ((0 {"1 (inds { x)) - 1) ,: (1 {"1 y)) [ (inds =. 0 {"1 y) }}
pairs =. ((_2&([\))@I.@:= ((0&{)"1))
magnitude =. (0&{"1@[ |:@,: +/"1@((3 2)&*"1)@:((1&{"1)@{))
fold =. (] [`replaceadjacent@.(gz@]) (pairs ((0$0)&[@])`magnitude@.(gz@[) ]))
calcmagnitude =. 1&{@:(,/@(] F.. fold)&(}: i._5))

start_jpm_ ''
] part1 =. calcmagnitude > (sum~/ (|. nums))
cartesian =. {@(,&<)
all_pairs =. (>@((1{] ~: 0{])&.>) # ]) ,/ (nums cartesian nums)
] part2 =. 0 ] F.. (] >. ((calcmagnitude@>@(sum~/) >. calcmagnitude@>@(sum/))@:>@:[)) all_pairs
showtotal_jpm_ ''
