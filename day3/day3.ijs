input =. > ". each 'm' fread 'day3/day3.txt'
0.5 (> *&#. <) +/ input % (0 { $ input)

filter =: dyad define
  row =. x { |: y
  row = ( +/ row % #row) < 0.5
)

stop =: monad define
  y [ _2 Z: (#y) = 0
)

calcox =. stop F.. {{ (0 +: (x filter y)) # y }}
calcco =. stop F.. {{ (x filter y) # y }}
input (calcox *&#. calcco) i. (1 { $input)
