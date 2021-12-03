dirs =. 'm' fread 'day2/day2.txt'

up      =. {{ (0,-y) }}
down    =. {{ (0, y) }}
forward =. {{ (y, 0) }}

*/ +/ ". dirs

up      =. {{ (0, 0, -y) }}
down    =. {{ (0, 0, y) }}
forward =. {{ (y, 0, 0) }}

*/ }: {{ y }} F.. {{ y + x + (0, (0 { x) * (2 { y) ,0) }} (0, (". dirs))
