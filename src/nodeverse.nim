## The Node Universe

import math
import random

type
  Node* = object
    id*: string
    x*, y*: int

proc `==`(a, b: Node): bool =
  a.id == b.id

type
  Nodeverse* = object
    nodes: seq[Node]

method add*(this: var Nodeverse, node: Node) {.base.} =
  if not this.nodes.contains(node): this.nodes.add(node)

method add*(this: var Nodeverse, id: string, x, y: int) {.base.} =
  this.add(Node(id:id, x:x, y:y))

proc dist_squared(a, b: Node): int =
  (a.x-b.x)^2 + (a.y-b.y)^2

method get_dist_to_closest(this: Nodeverse, from_node: Node): int {.base.} =
  result = dist_squared(this.nodes[0], from_node)
  for i in 1..this.nodes.high:
    if result == 0: return
    let dist = dist_squared(this.nodes[i], from_node)
    if dist < result: result = dist

method move_random(node: var Node, max_dist: int) {.base.} =
  node.x.inc(rand(max_dist) - (max_dist div 2))
  node.y.inc(rand(max_dist) - (max_dist div 2))

method evolve*(this: var Nodeverse) {.base.} =
  for node in this.nodes.mitems:
    let dist = this.get_dist_to_closest(node)
    if dist < 2 or dist > 5: node.move_random(5)

method print*(this: Nodeverse) {.base.} =
  if this.nodes.len() == 0:
    echo "Nodeverse empty"
    return
  for node in this.nodes:
    echo "(", node.x, ", ", node.y, ")"