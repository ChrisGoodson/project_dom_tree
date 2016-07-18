class DomTree
  attr_reader :string, :document

  def initialize
    @document = Node.new("document head", nil, 0, [])
  end

  def parse_string(str)
    str.scan(/<.*?>|[[a-zA-Z]\p{P}\s]*/).map(&:strip).reject(&:empty?)
  end

  def build_tree(str)
    parsed_html = parse_string(str)
    top = @document
    parsed_html.each do |item|
      node = build_node(item)
      top = add_node(node, top)
    end
  end

  def add_node(node, top)
    if opening_tag?(node.type)
      add_opening_tag(node, top)
    else
      add_other_tag(node, top)
    end
  end

  def add_opening_tag(node, top)
    top.children << node
    node.children, node.parent, node.depth =
                                    [], top, (top.depth + 1)
    node
  end

  def add_other_tag(node, top)
    if closing_tag?(node.type)
      top.parent
    else
      top.children << node
      node.parent, node.depth = top, (top.depth + 1)
      top
    end
  end

  def opening_tag?(item)
    item[0] == "<" && item[1] != "/"
  end

  def closing_tag?(item)
    item[0] == "<" && item[1] == "/"
  end

  def build_node(type)
    Node.new(type)
  end

  def print_to_file
  file = File.open('output.html', 'w')
  render(@document, file)
  file.close
  end

  def render(top, file)
    file << "#{"  " * top.depth}#{top.type}\n"
    top.children.each { |element| render(element, file) } if top.children
    file << "#{"  " * top.depth}#{make_closing(top.type)}>\n" if opening_tag?(top.type)
  end

  def make_closing(tag)
    match = tag.match(/<(\w*\d*)/).to_s
    match.insert(1, "/")
  end
end
