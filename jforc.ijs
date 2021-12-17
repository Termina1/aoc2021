NB. File definitions for'J For C Programmers'
NB. Copyright (c) 2002 Henry H. Rich
cocurrent 'z'
require 'colib'

NB.*Ts v-- Dual.  y is a string; execute it x times
NB. (default 1); result is (average time),(space used)
Ts =: 6!:2 , 7!:2@]

NB.*ReadFile v-- Monad.  y is boxed filename, result is character-list contents
ReadFile =: 1!:1

NB.*WriteFile v-- Dyad.  y is boxed filename, x is character-list contents
WriteFile =: 1!:2

NB.*AppendFile v-- Dyad.  y is boxed filename, x is character-list contents
AppendFile =: 1!:3

NB.*EraseFile v-- Monad.  y is boxed filename, which is erased
EraseFile =: 1!:55

NB.*PublishEntryPoints v--  Dual. y is string of entry-point names, separated by spaces
NB. x is the level number at which we should publish the entry points (default _1, 'z')
NB. we publish these names in the locale at position x in the path
PublishEntryPoints =: 3 : 0
_1 PublishEntryPoints y
:
NB. The rhs of the assigment below interprets the names as gerunds
path =. '_' (,,[) x {:: (<,'z') ,~^:(-.@*@#@]) 18!:2 current =. 18!:5 ''
l =. ,&path^:('_'&~:@{:)&.> ;: y
r =. ,&('_' (,,[) > current)@(({.~ i:&'_')@}:^:('_'&=@{:))&.> ;: y
NB. The gerund assignment requires more than one name, so duplicate the last:
('`' , ;:^:_1 (, {:) l) =: (, {:) r
)

NB.*Display v-- Monad.  Type y on the terminal
Display =: (i.0 0)"_ ((1!:2) 2:)

NB.*BoolToNdx v--  Monad.  y is a Boolean list; result is indexes of 1s
BoolToNdx =: (# i.@:#)"1

NB.*Endtoend a--  Dual.  Apply [x] u on y; run results together
Endtoend =: 1 : ';@:(<@u)'

NB.*Butifnull c--  Dual.  Conjunction: u unless y has no items; then v
Butifnull =: 2 : 'v"_`u@.(*@#@])'

NB.*Butifxnull c--  Dual.  Conjunction: u unless x has no items; then v
Butifxnull =: 2 : 'v"_`u@.(*@#@[)'

NB.*Ifany a--  Dual. Execute u, but skip it if y has no items
Ifany =: ^: (*@#@])

NB.*Ifany a-- Dual.  Execute u, but skip it if x has no items
Ifanyx =: ^: (*@#@[)

NB.*Bivalent c--  Dual.  u v y if monad, x u (v y) if dyad
Bivalent =: 2 : 'u^:(1:`(]v))'

NB.*Xuvy c-- Dual.  [x] (u v) y
Xuvy =: 2 : 'u v'

NB.*Yuvx c-- Dual.  [y] (u v) x
Yuvx =: 2 : '(u v)~'

NB.*Ux_Vy c-- Dual.  (u x) v y
Ux_Vy =: 2 : '(v~ u)~'

NB.*Uy_Vx c-- Dual.  (u y) v x
Uy_Vx =: 2 : 'v~ u'

NB.*Vx_Uy c-- Dual.  (v x) u y
Vx_Uy =: 2 : '(u~ v)~'

NB.*Vy_Ux c-- Dual.  (v y) u x
Vy_Ux =: 2 : 'u~ v'

NB.*UsedToSelect a-- keep items of y for which u y is 1
UsedToSelect =: 1 : 'u # ]'

NB.*LoopWithInitial c-- Monad.  u is verb, n is initial value
NB. u is applied to the items sequentially  At each application
NB. of u, x is the next item of the initial y and y is
NB. the result of the previous execution of u (initial y is n)
LoopWithInitial =: 2 : 'u&.>/\. &.(,&(<v))&.|.&.(<"_1)'

NB.*InLocales c-- Dual.  u is verb, n is list of locales, [x] u y is executed in each locale
InLocales =: 2 : 0
l1 =. 18!:5 ''
for_l. n do.
  cocurrent l
  u y
end.
cocurrent l1
''
:
l1 =. 18!:5 ''
for_l. n do.
  cocurrent l
  x u y
end.
cocurrent l1
''
)

NB.*DefSockets v-- Monad.  y is '', result is empty
NB. The socket names are inserted into the search path for the current locale
DefSockets =: (copath~ ('jsocket';'jdefs')&,@:copath) @: coname

NB.*InitIfUndef a--  Initialize a global, but not if it's already been initialized
NB. Example: 'name' InitIfUndef 5
InitIfUndef =: (, ('_'&([,],[))@(>@(18!:5)@(0&$)) ) Ux_Vy ((4 : '(x) =: y')^:(0:>(4!:0)@<@[))
