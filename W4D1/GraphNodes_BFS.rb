require "byebug"
require "set"

class GraphNode
  attr_accessor :val, :neighbors

  #@@all = []

  def initialize(val)
    self.val = val
    self.neighbors = []
    #@@all << self
  end

  
end

a = GraphNode.new('a')
b = GraphNode.new('b')
c = GraphNode.new('c')
d = GraphNode.new('d')
e = GraphNode.new('e')
f = GraphNode.new('f')
a.neighbors = [b, c, e]
c.neighbors = [b, d]
e.neighbors = [a]
f.neighbors = [e]

def bfs(starting_node, target_value, visited = Set.new())
  #debugger
  return nil if visited.include?(starting_node.val)

  return starting_node.val if starting_node.val == target_value
  visited.add(starting_node.val)

  starting_node.neighbors.each do |neighbor|
    bfs(neighbor, target_value, visited)
  end

  nil
end
 
bfs(a, "b")