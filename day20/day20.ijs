pad =. {{ (x,x,"1 y, x) (,"1) x }} NB. padding for matrix
pad2 =. {{ (x&pad)^:2 y }}
image =. > 2 }. data [ code =. > {. data [ data =. (".@(('#';'1 ';'.';'0 ')&stringreplace)@dltb each) <"1'm' fread 'day20/day20.txt'
print =. {&'.#'
enchance =. ({&code)@:(#.@:(,/))
step =. (-.@:[) ; ((3 3) (enchance (;. _3)) pad2)
] part1 =. +/,>1{ (step&>/)^:2 (0;image)
] part2 =. +/,>1{ (step&>/)^:50 (0;image)
