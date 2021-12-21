load 'regex'
data =. 'm' fread 'day19/day19.txt'
iparsed =. (>@((2&~:)@+/"1@;@(0&<:)@('--- scanner .+? ---'&rxmatch) each) (".@dltb each)@#  ]) (<"1 data)
] input =. >&.(>) ((1, iparsed = a:) <;._1 (a:, iparsed))
sin =. 1&o.
cos =. 2&o.
ap =. `: 0
dtor =. (%&180)@o.
idm =. {{ (|:@((3 $ 0)&(y })))^:2 (3 3 $ 1)}}
rtm =. {{ x (idm@[ 1&((<(2#x)) })@:* ((_1&|.@{: ,~ ])^:2)@,:@((cos`(-@sin)`sin) ap)@dtor@]) y }}
cartesian =. {@(,&<)
grads =. <"0 (0 90 180 270)
perms =. {{ }. >@((,/@:((;)&.>)@cartesian)^:x ]) y }}
round=: <.@+&0.5
dotp =. (+/ . *)
xyzrot =. round@(i.@#  dotp/@:(>@(rtm&.>)) ])
rotations =. ~. xyzrot each <"1 (2 perms grads)
calcrots =. {{ ((> x)&dotp) each y }}
combinations =. (a:&~: # ])@:,/@(({. cartesian }.)\.)
] t =. > 0 { combinations input
intersect =. ([ -. -.)
log =. (fappend&'day19/log.txt')@":
commonpoints =. monad define
  rotated =. > (1 { y)
  z =. (rotated calcrots rotations)
  ref =. > (0 { y)
  smoutput ref
  i =. 0
  found =. 0
  for_ijk. ref do.
    left =. ref -"1 ijk
    smoutput 'left index';i
    for_ijk. i.((#rotated)) do.
      smoutput 'right index';ijk
      rights =. ({.@(ijk&}.) -"1 ])&.> z
      common =. (left&intersect)&.> rights
      commonpoints =. ((4&=)@>@(#&.>) # ]) common
      if. (#commonpoints) > 0 do.
        smoutput {. commonpoints
        found =. 1
        break.
      end.
    end.
    if. found do.
      break.
    end.
    i =. i + 1
  end.
)
commonpoints t
