## Spread

import nodeverse
import random

randomize()

var nv: Nodeverse

for i in 1..9:
    nv.add($i, 0, 0)
echo nv
echo ""
for i in 0..10:
    nv.evolve()
echo nv