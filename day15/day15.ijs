pn =: <(0 1000000000)
data =. > ". each <"0 'm' fread 'day15/day15.txt'
pad =. {{ (pn,pn,"1 y, pn) (,"1) pn }} NB. padding for matrix

selectadjacent =. ((<0 1),(<1 0),(<2 1), (<1 2))&{ NB. pick all adjacent points
mapadjacent =.(((((< 1 1)&{)`'')&;)@(selectadjacent`''&(;~))) NB. this gerund allows us to build verb for mapping adjacent elenents with window filter
filternonvisit =. (>&0 *. <&1000000000)
fillempty =. (]&0)^:(0&>:@#)
nmin =. (0&{@:>@:[ (+^:((0&<)@:])) fillempty@:<.@:(filternonvisit # ])@:(1&{"1)@:>@:])
wavefilter =. (mapadjacent (0&{@>@[ <@:, ((1&{)@:>@:[ (<./)@:fillempty@:(0&< # ])@:, ,/@:nmin))`'') `: 6
end =. <(($data) - 1)
start_calc =. dyad define
  ((x&{ <@:, x&{) (x }) ((,&0)&.>)@<"0) y
)

solve =. (1 1,: 3 3)&(wavefilter (;. _3))@pad^:_
get_minimal_path =. (-~)/@:>@:((<0 0)&{)
] part1 =. get_minimal_path (solve (end start_calc data))

full_solve =. monad define
  full_solution =. 5 5 $ 0
  for_ijk. i. 5 do.
    i =. ijk
    for_ijk. i. 5 do.
      start =. end start_calc (1 + (9 | (ijk + i) + (y - 1)))
      full_solution =. (get_minimal_path (solve start)) (<(i, ijk)) } full_solution
    end.
  end.
  full_solution
)
full_solution =. full_solve data

] part2 =. get_minimal_path solve ((<(4 4)) start_calc full_solution)
