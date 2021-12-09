data =. > ". each <"0 'm' fread 'day9/day9.txt'
pad =. {{ (100,100,"1 y, 100) (,"1) 100 }}
selectadjacent =. ((<0 1),(<1 0),(<2 1), (<1 2))&{
mapadjacent =.(((((< 1 1)&{)`'')&;)@(selectadjacent`''&(;~)))

filterlowpoints =. (mapadjacent ((0&=)@(+/)@:>:`'')) `: 6
lowpoints =. (1 1,: 3 3) filterlowpoints ;. _3  (pad data)
+/^:2 lowpoints * (data + 1)

basins =.((~:)&9 * ]) (data + lowpoints * 10)
updatebasins =. (mapadjacent ([ (0&<@(+/))@:= (] (-&9)@(])@:#~ (100&> *. 10&<:))@:])`'') `: 6
step =. (+ 10&*@(((1 1,: 3 3)&(updatebasins (;. _3)))@pad))
(>&0 * [) ((step ^:9) basins) - 10
