data =. > ('-'&splitstring)@dltb each <"1('m' fread 'day12/day12.txt')
V =. s: ~. ,/ data
vmap =. I.@:([ = s:@<@])
Z =. u:^:_1 'Z'
graph =. (] <. |:) 1 (,"2 >((V&vmap) each data)) } (((#V), (#V)) $ _)
draw =. (<"0@(] ,.)@((s:<'_')&,)@[ ,. (,&(<"0@]))) NB. V draw graph displays readable adj table
isbig =. {{Z >: (u:^:_1) 0 { ; s:^:_1 y { V }}
V draw graph
small =. (I. -. > isbig each (i. #V)) -. ((V vmap 'start'), (V vmap 'end'))

hassmall2 =. e.`(([ e. ]) *. (#@:] ~: #@:~.)@(e.&small # ])@:])@.(e.&small@:[)
simplecheck =. e.&x

NB. change hassmall2 to simplecheck for part 1 result
genpath =. dyad define
 ((1~:])@>@(#&.>) # ]) (x&(,~))^:(-.@:((hassmall2&x)`((0"_))@.isbig)) each (<"0 y)
)

search =. monad define
  paths =. , (< V vmap 'start')
  finished =. $0
  while. (#paths) > 0 do.
    'paths finished' =. ((#&paths)@:-. ; <@:(,&finished)@:#&paths)(; ((V vmap 'end')&e. each) paths)
    paths =. ;paths (genpath each) ([:I._~:])&.> <"1((0{])&.> paths){y
  end.
  finished
)

$ ~. search graph
