## The Node Universe

import math

type
  Node* = object
    id*: string
    x*, y*: int

type
  Nodeverse* = object
    nodes: seq[Node]

method add*(this: var Nodeverse, node: Node) {.base.} =
  this.nodes.add(node)

proc dist_squared(a, b: Node): int =
  (a.x-b.x)^2 + (a.y-b.y)^2

method print*(this: Nodeverse) {.base.} =
  if this.nodes.len() == 0:
    echo "Nodeverse empty"
    return
  for node in this.nodes:
    echo "(", node.x, ", ", node.y, ")"