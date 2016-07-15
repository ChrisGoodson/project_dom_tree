#we'll have nodes
#nodes like type
#no attributes in example
#we're going to need a tree
#we'll feed it a string and it will break ever differnt type
# to it's own node and add to the tree.
#outputter method that prints the tree.


Node = Struct.new(:type, :children :parent)

class DomTree
  attr_reader :string

  def initialize(str)
    @string = str
    @document = build_node("document head")
    @parsed_string = []
  end

  def build_node(type)
    Node.new(type)
  end

  def parse_string(str)
    @parsed_string = str.scan(/<.*>|.*/).map(&:strip).reject(&:empty?)
  end

  def build_tree
    #loop through each item in parse string;
    #for each item we want to build a node and set parent's node pointers;
    #for each item in the array, loop through each item in array
    #and check if its an html item[0] == < && item[1] != /
    top = @document
    @parsed_string.each do |item|
      if item[0] == "<" && item[1] != "/"
        top.children << top = Node.new(item, [], top)
      elsif item[0] == "<" && item[1] == "/"
        top = top.parent
      else
        top.children << Node.new(item, nil, top)
    end


    

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
