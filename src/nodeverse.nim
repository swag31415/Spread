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
  result = high(int)
  for node in this.nodes:
    if node == from_node: continue
    let dist = dist_squared(node, from_node)
    if dist == 0:
      return dist
    elif dist < result:
      result = dist

method move_random(node: var Node, max_dist: int) {.base.} =
  node.x.inc(rand(max_dist) - (max_dist div 2))
  node.y.inc(rand(max_dist) - (max_dist div 2))

method evolve*(this: var Nodeverse) {.base.} =
  for node in this.nodes.mitems:
    let dist = this.get_dist_to_closest(node)
    if dist < 4 or dist > 25: node.move_random(1)

proc `$`*(this: Nodeverse): string =
  if this.nodes.len() == 0:
    return "Nodeverse empty"
  result = "["
  for node in this.nodes:
    result.add("(" & $node.x & ", " & $node.y & "), ")
  result.setLen(result.len - 2)
  result.add("]")