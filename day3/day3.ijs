input =. > ". each 'm' fread 'day3/day3.txt'
avg_sum =. +/ input % (0 { $ input)
0.5 (> *&#. <) avg_sum

filterox =: dyad define
  row =. x { |: y
  avg =. +/ row % #row
  (row = avg >: 0.5) # y
)

filterco =: dyad define
  row =. x { |: y
  avg =. +/ row % #row
  (row = avg < 0.5) # y
)

stop =: monad define
  y [ _2 Z: (#y) = 0
)

calcox =. stop F.. filterox
calcco =. stop F.. filterco

input (calcco *&#. calcox) i. (1 { $input)
