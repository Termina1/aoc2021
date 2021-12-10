data =. (<a:;a:;0) { (> ". each <"0 > ('[1]5(2)6{3}7<4>8'&charsub) each <"1 'm' fread 'day10/day10.txt')

push =. <@([ , >@:])
pop =. <@([ ((>@((0&,)@[ push ]))`(}.@]))@.(=&(0&{@])) >@])
gerund =. ]`((1&push)@])`((2&push)@])`((3&push)@])`((4&push)@])`((1&pop)@])`((2&pop)@])`((3&pop)@])`((4&pop)@])
stack =. (#data) # <_

endstate =. (stack (] F.. {{ x gerund@.([ * ((0&<)@(0&{)@|:@>@]))"0 y }})  (|: data))
prize =. 0 57 3 1197 25137
corrupted =. ((0 = 0 { (|: >endstate)) # (1 { (|: >endstate)))
+/ corrupted { prize

incomplete =. (0 < 0 { (|: >endstate)) # endstate
prize =. 0 2 1 3 4
scores =. (\: { ]) > 0&(] F.. ([ + (5&*)@]))@({&prize)@(<&5 # ]) each incomplete
(>. (#scores) % 2) { scores
