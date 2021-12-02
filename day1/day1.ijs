readfile =: 1!:1
fn =. < 'day1/day1.txt'
data =. readfile fn
data =. |; ". each cutopen toJ data
+/ (}. _1 |. data) > (}. data)
