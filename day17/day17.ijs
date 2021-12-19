load 'jpm'

] 'xz yz' =. <"1 (_2 ]\ (". ('x=';'';'y=';'';'..';' ';',';'';'-';'_') stringreplace ('m' fread 'day17/day17.txt')))
] yz =. |. yz

xt =. {{ ((((2 * x) - (z - 1)) * z) % 2) [ (z =. (((0 { x)&<.)`]@.(i.@#)) (2 $ y))  }}

minx =. <. 2 %: ((2 * (0 { xz)) - 1)
maxx =. 1 + 1 { xz
maxy =. 1 + | (1 { yz)

tbound =. dyad define
  b =. -((2 * x) + 1)
  d =. ((*: b) - (8 * y))
  if. d >: 0 do.
    d =. (%: d) % 2
    b =. b % 2
    ((_&[)^:(0&>) ((-b) - d)) <. ((-b) + d)
  else.
  _
  end.
)

calcmaxh =. 1 { ([ (, xt ]) (0&>.)@])
intersect =. (>.`<.)@.(i.@:#@])
round =. >.`<.@.(i.@#@:])

solve =. monad define
  results =. 0$0
  ii =. 0
  xx =. minx }. (i. maxx)
  yy =. (}: -(i.-maxy)), (i.maxy)
  hitters =. 0
  maxh =. 0
  tbound_m =. tbound M.
  for_ijk. xx do.
    vx =. ijk
    txrange =. round vx tbound_m"0 xz
    for_ijk. yy do.
      vy =. ijk
      tyrange =. round vy tbound_m"0 yz
      pass =. 0 <: (-~/ (txrange intersect tyrange))
      hitters =. (1&+)^:(pass) hitters
      maxh =. maxh >. (vx (calcmaxh)^:(pass) vy)
      ii =. ii + 1
    end.
  end.
  hitters, maxh, ii
)

start_jpm_ ''
solve 0
showtotal_jpm_ ''
