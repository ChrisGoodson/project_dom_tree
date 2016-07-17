#we'll have nodes
#nodes like type
#no attributes in example
#we're going to need a tree
#we'll feed it a string and it will break ever differnt type
# to it's own node and add to the tree.
#outputter method that prints the tree.


Node = Struct.new(:type, :children, :parent, :depth )

class DomTree
  attr_reader :string, :document

  def initialize
    @document = Node.new("document head", [], nil, 0)
  end

  def parse_string(str)
    str.scan(/<.*?>|[\w\p{P}\s]*/).map(&:strip).reject(&:empty?)
  end

  def build_tree(str)
    parsed_string = parse_string(str)
    top = @document
    parsed_string.each do |item|
      if item[0] == "<" && item[1] != "/"
        top.children << top = Node.new(item, [], top, top.depth + 1)
      elsif item[0] == "<" && item[1] == "/"
        top.children << Node.new(item, nil, top, top.depth)
        top = top.parent
      else
        top.children << Node.new(item, nil, top, top.depth + 1)
      end
    end
  end

  def render
    queue = [@document]
    while item = queue.shift
      item.children.reverse_each { |type| queue.unshift(type) } if item.children
      p "#{"  " * item.depth}#{item.type}"
    end
  end

end

# dom = DomTree.new
# file = File.open("test.html", "rb")
# contents = file.read
# file.close
# dom.build_tree(contents)
# dom.render

# "<div>
#   div text before
#   <p>
#     p text
#   </p>
#   <div>
#     more div text
#   </div>
#   div text after
# </div>"




# # The HTML string version
# # You could read it in from a file instead if so inclined,
# #   which would give you newline characters too
# html_string = "<div>  div text before  <p>    p text  </p>  <div>    more div text  </div>  div text after</div>"

# # Now pull that string into a simple data structure
# data_structure = parser_script( html_string )

# # Finally, output the string again.
# # It doesn't have to have pretty spacing like it does here...
# outputter( data_structure )
# # <div>
# #   div text before
# #   <p>
# #     p text
# #   </p>
# #   <div>
# #     more div text
# #   </div>
# #   div text after
# # </div>
