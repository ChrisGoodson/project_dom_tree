#we'll have nodes
#nodes like type
#no attributes in example
#we're going to need a tree
#we'll feed it a string and it will break ever differnt type
# to it's own node and add to the tree.
#outputter method that prints the tree.


Node = Struct.new(:type, :children)

class DomTree
  attr_reader :string

  def initialize(str)
    @string = str
  end

  def build_node(type)
    Node.new(type)
  end

  def parse_string(str)
    str.scan(/<.*>|.*/).map(&:strip).reject(&:empty?)
    # b = str.split("\n").map { |item| item.strip }
    #.reject { |item| item.match(/<\/(\w*\d*)>/)}
    # b.map do |item|
    #   if match = item.match(/<(\w*\d*)>/)
    #     match.captures[0]
    #   elsif text = item.match(/\A(.*)\z/)
    #     text.captures[0]
    #   end
    # end.compact
  end

  def build_tree
    
  end




end



dom = DomTree.new("<div>
  div text before
  <p>
    p text
  </p>
  <div>
    more div text
  </div>
  div text after
</div>")

p dom.parse_string(dom.string)

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
