data =. 'm' fread 'day14/day14.txt'
A =. u:^:_1 'A'
max =. 26 #. (26 * 26)
mapletter =. (-&A)@(u:^:_1)
unmappair =. u:@(+&A)@((2#26)&#:)
word =. 26 #. 2 ]\ (> mapletter each <"0 dltb (0 { data))
cells =: (max $ 0)

grow =. 26 #. each > (>@(0&{) ; (>@(1&{) (,~&:(0&{) ,: ,&:{:) >@(0&{))) each <"1 mapletter each > (' -> '&splitstring)@dltb each <"1 (2 }. data)
update_cells =. dyad define
  cells =: (x + (y { cells)) y } cells
  0
)

(<"0 (#word)$1) (update_cells each) (<"0 word)

main =. monad define
  i =. 0
  while. i < y do.
    ] cur =. (> 0 {"1 grow) { cells
    (<"0 cur) (update_cells each) (1 {"1 grow)
    nw =. (> 0 {"1 grow) { cells
    cells =: (nw - cur) (> 0 {"1 grow) } cells
    i =. i + 1
  end.
)
main 40
] letters =. 1 {"1 <"0 > ((2#26)&#: each) (I. (cells > 0))
] occurs =. (cells > 0) # cells
] counter =: 26$0
count =. dyad define
  counter =: (x + (y { counter)) y } counter
  0
)
] first_letter =. 0 { (2#26) #: (0 { word)
occurs count each letters
counter =: (1 + (first_letter { counter)) first_letter } counter
(>./ - <./) (counter > 0) # counter

NB. |: (unmappair each I. (cells > 0)) ,: <"0((cells > 0) # cells)
