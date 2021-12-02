readfile =: 1!:1
fn =. < 'day1/day1.txt'
data =. readfile fn
data =. |; ". each cutopen toJ data

day1 =. 4 : 0
+/ ((}. (- x) |. y) < (}. y))
)

1 day1 data NB. part 1
3 day1 data NB. part 1
