data =. 'm' fread 'day5/day5.txt')

line =. monad define
  t =. -/ y
  size =. 1 + >./ | t
  step =. - t % | t
  z =. 1000 1000 $ 0
  coord =. (<(0)){ y
  for. i. size do.
    z =. 1 (<(coord)) } z
    coord =. coord + step
  end.
  z
)

+/ +/ 1 < +/ > line each cutopen > ". each > ('->' & splitstring) each cutopen data
