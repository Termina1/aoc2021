data =. 0 { ". 'm' fread 'day6/day6.txt'
step =. (0&{ ((] (6}~) (+ 6&{)) , [) }.)
frame =. (9#0) {{ y }} F.. {{ (+/ data = x) x } y }} i.6
+/ (step ^: 256) frame
