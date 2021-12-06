data =. 0 { ". 'm' fread 'day6/day6.txt'
step =. monad define
  head =. 0 { y
  shifted =. }. y
  (head + (6 { shifted)) 6 } shifted, head
)
frame =. (9#0) {{ y }} F.. {{ (+/ data = x) x } y }} i.6
 +/ (step ^: 256) frame
