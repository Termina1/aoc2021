data =. dltb each <"1 'm' fread 'day13/day13.txt'
break =. {. I. data = <''
points =. ". > (break {. data)
mx =. (1&+)^:((0&~:)@(2&|)) >./(0 {"1 points) [ my =. (1&+)^:((0&~:)@(2&|)) >./(1 {"1 points)
table =. 1 (|."1 points) } ((my + 1), (mx + 1)) $ 0
folds =. ". > ('fold along y=';'0 ';'fold along x=';'1 ')&stringreplace each (break + 1) }. data

fold =. (|.@}.@:}. +. {.)
foldover =. ((1{[) fold ])`((1{[) fold"1 ])@.(0{[)

] part1 =. +/^:2 (0 { folds) foldover table
] part2 =. (table ] F.. foldover folds) { '.#'
