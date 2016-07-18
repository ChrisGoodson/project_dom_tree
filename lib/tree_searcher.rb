require_relative "node"
require_relative "dom_tree"
require_relative "node_renderer"

class TreeSearcher

  def initialize(tree)
    @tree = tree
  end

  def search_by(attribute, text)
    stack = [@tree]
    matching_nodes = []
    while node = stack.pop
      matching_nodes += match_attributes(node, attribute, text)
      stack += add_children_to_stack(node)
    end
    matching_nodes
  end

  def add_children_to_stack(node)
    stack = []
    if children = node.children
      children.each { |child| stack << child}
    end
    stack
  end

  def match_attributes(node, attribute, text)
    arr = []
    if att = get_attribute(node.type, attribute.to_s)
      att.each { |item| arr << node if item == text }
    elsif text == node.type
      arr << node
    end
    arr
  end

  def get_attribute(str, attribute)
    if pattern = str.match(/#{attribute}\s?=\s?"(.*?)"/)
      return pattern.captures[0].split if attribute == "class"
      pattern.captures
    end
  end

end

dom = DomTree.new
file = File.open("test.html", "rb")
contents = file.read
file.close
dom.build_tree(contents)
searcher = TreeSearcher.new(dom.document)
node = searcher.search_by(:class, "top-div")[0]
NodeRenderer.new(dom.document).render(node)
dom.print_to_file
