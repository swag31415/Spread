## The Node Universe

type
  Node* = object
    id*: string
    x*, y*: int

type
  Nodeverse* = object
    nodes: seq[Node]

method add*(this: var Nodeverse, node: Node) {.base.} =
  this.nodes.add(node)

method print*(this: Nodeverse) {.base.} =
  if this.nodes.len() == 0:
    echo "Nodeverse empty"
    return
  for node in this.nodes:
    echo "(", node.x, ", ", node.y, ")"