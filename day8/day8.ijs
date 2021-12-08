data =. >' | '&splitstring each cutopen 'm' fread 'day8/day8.txt'
parse =. {{ #: > +/ each ". > ('a';' 1 ';'b';' 2 ';'c';' 4 ';'d';' 8 ';'e';' 16 ';'f';' 32 ';'g';' 64 ';' '; ';')&(rplc~)@dtbs each y }}
encode =. parse 0 {"1 data

filterneg =. {{,/"2 ((0 = +/"1 (0 > y)) #"0 y) }}
filter =. {{(+/"2 ,/"2 (x = +/"1 (filterneg y)) #"0 y) }}
one =. cf =. 2 filter encode
seven =. 3 filter encode
four =. 4 filter encode
eight =. 7 filter encode
a =. seven - one
bd =. four - one
eg =. 0 < eight - (four + seven)
g =. 1 filter (encode -"1 (cf + a + bd))
e =. eg - g
d =. 1 filter encode -"1 (a + cf + g)
b =. bd - d
c =. 1 filter encode -"1 (a +d + e + g)
f =. cf - c
two =. a + c + d + e + g
three =. a + c + d + f + g
five =. a + b + d + f + g
six =. a + b + d + e + f + g
nine =. a + b + c + d + f + g

digits =. parse 1 {"1 data

numbers =. one;two;three;four;five;six;seven;eight;nine
solve =. dyad define
  result =. (}:$y)$0
  for_ijk. x do.
    result =. result + ((<"1 > ijk) = (<"1 y)) * (ijk_index + 1)
  end.
)

solution =. numbers solve digits

+/^:2 (solution = 1) + (solution = 4) + (solution = 7) + (solution  = 8)
+/ 10 #. solution
