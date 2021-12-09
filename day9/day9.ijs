pn =: 1000000000
data =. > ". each <"0 'm' fread 'day9/day9.txt'
pad =. {{ (pn,pn,"1 y, pn) (,"1) pn }} NB. padding for matrix
selectadjacent =. ((<0 1),(<1 0),(<2 1), (<1 2))&{ NB. pick all adjacent points
mapadjacent =.(((((< 1 1)&{)`'')&;)@(selectadjacent`''&(;~))) NB. this gerund allows us to build verb for mapping adjacent elenents with window filter

filterlowpoints =. (mapadjacent ((0&=)@(+/)@:>:`'')) `: 6
lowpoints =. (1 1,: 3 3) filterlowpoints ;. _3  (pad data)
+/^:2 lowpoints * (data + 1)

test =. dyad define
  z =. x + (y - (10 | y))
  ind =. y >: 10
  if. (x < 9) *. (0 < (+/ ind)) do.
    <./ (ind # z)
  else.
    x
  end.
)

t =. $ lowpoints
marked_lowpoints =. ((t $ i. */t) * 10) * lowpoints NB. Here we add (10 * cellnum aka base) so we could separate low points in different basins
basins =. (data + marked_lowpoints) NB. Starting point
updatebasins =. (mapadjacent ([ test (] #~ (pn&> *. 10&<:))@:])`'') `: 6
step =. (((1 1,: 3 3)&(updatebasins (;. _3)))@pad)
solution =. ((step ^:9) basins)

ids =. (I.@>&0 t {) (,/ marked_lowpoints) NB. retreieve all different bases for basins

sum =. dyad define
  z =. (x <: solution) *. ((x + 10) > solution)
  +/^:2 z
)
sizes =. solution ] F:. sum ids NB. As all points from one basin are between base and base + 10, we just use comparison to calc basin size foe every base

*/ 3 {. (\: sizes) { sizes
