class NodeRenderer

  def initialize(tree)
    @tree = tree
  end

  def render(node)
    node = @tree if node == nil
    nodes_below(node)
    node_type_count(node)
    node_attributes(node)
  end

  def nodes_below(node)
    stack = [node]
    count = 0
    while item = stack.pop
      count += item.children.length if item.children
      stack += add_children_to_stack(item)
    end
    p "There are #{count} children in this nodes subtree"
  end

  def node_type_count(node)
    stack = [node]
    type_hash = Hash.new(0)
    while item = stack.pop
      match = get_type(item.type)
      type_hash = update_hash(match, type_hash, item, node)
      stack += add_children_to_stack(item)
    end
    print_hash(type_hash)
  end

  def add_children_to_stack(item)
    stack = []
    if children = item.children
      children.each { |child| stack << child }
    end
    stack
  end

  def print_hash(hash)
    hash.each do |key, val|
      puts "There are #{val} #{key}(s) in this nodes subtree"
    end
  end

  def update_hash(match, hash, item, node)
    if blank_or_star_node?(match, item, node)
      match == nil ? hash["text"] += 1 : hash[match] += 1
    end
    hash
  end

  def blank_or_star_node?(match, item, node)
    match != "" && item != node
  end

  def get_type(tag)
    if match = tag.match(/<([a-z]*\d*)\W/)
      match.captures[0]
    end
  end

  def node_attributes(node)
    if attributes = get_node_attr(node.type)
      p attributes
    end
  end

  def get_node_attr(tag)
    if match = tag.match(/<[a-z]*\d*(.*)>/)
      match.captures[0]
    end
  end

end
