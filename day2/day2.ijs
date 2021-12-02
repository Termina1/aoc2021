dirs =. 'm' fread 'day2/day2.txt'

up      =. {{ (0,-y) }}
down    =. {{ (0, y) }}
forward =. {{ (y, 0) }}

*/ +/ ". dirs

up      =. {{ (0, 0 -y) }}
down    =. {{ (0, 0, y) }}
forward =. {{ (y, 0, 0) }}

v=: dyad define
  z=. y + x + (0, (0 { x) * (2 { y) ,0)
  z [smoutput x ; 'v' ; y ; '-->' ; z
)

u=: monad define
  y
)

*/ }: u F.. v (0, (". dirs))
