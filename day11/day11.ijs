data =. > ". each <"0 'm' fread 'day11/day11.txt'
pad =. {{ (0,0,"1 y, 0) (,"1) 0 }}
step =. monad define
  z =. y + 1
  mask =. (100 | z) > 9
  while. (+/^:2 (mask = 1)) > 0 do.
    z =. z + (1 1,: 3 3)&(((0&[)`((+/^:2)@(1&=))@.(0&=@((<1 1)&{))) (;. _3))@pad mask
    mask =.((100 | z) > 9) + (mask * 2)
  end.
  z + (mask > 0) * ((mask > 0) * 100 - (100 | z))
)
] part1 =. +/^:2 <."0 ((step ^:100 data) % 100)

syncronize =. monad define
  z =. y
  i =. 0
  while. (+/^:2 (100 | z)) > 0 do.
    z =. step z
    i =. i + 1
  end.
  i
)
] part2 =. syncronize data
