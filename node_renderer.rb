class NodeRenderer

  def initialize(tree)
    @tree = tree
  end

  def render(node = @tree)
    nodes_below(node)
    node_type_count(node)
    node_attributes(node)
  end

  def nodes_below(node)
    queue = [node]
    count = 0
    while item = queue.pop
      if children = item.children
        children.each do |child|
          queue << child
          count += 1
        end
      end
    end
    p "There are #{count} children in this nodes subtree"
  end

  def node_type_count(node)
    queue = [node]
    type_hash = Hash.new(0)
    while item = queue.pop
      match = get_type(item.type)
      if match != "" && item != node
        if match == nil
          type_hash["text"] += 1
        else
          type_hash[match] += 1
        end
      end
      if children = item.children
        children.each do |child|
          queue << child
        end
      end
    end
    type_hash.each do |key, val|
      puts "There are #{val} #{key}(s) if this nodes subtree"
    end
  end

  def get_type(tag)
    if match = tag.match(/<([a-z]*\d*)\W/)
      match.captures[0]
    end
  end

  def node_attributes(node)
    if attributes = get_attibutes(node.type)
      p attributes
    end
  end

  def get_attibutes(tag)
    if match = tag.match(/<[a-z]*\d*(.*)>/)
      match.captures[0]
    end
  end

end

# dom = DomTree.new
# file = File.open("test.html", "rb")
# contents = file.read
# file.close
# dom.build_tree(contents)
# render = NodeRenderer(dom.document)
