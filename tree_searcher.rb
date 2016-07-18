require_relative "dom_tree"
require_relative "node_renderer"

class TreeSearcher

  def initialize(tree)
    @tree = tree
  end

  def search_by(attribute, text)
    send(attribute, text)
  end

  def class(text)
    queue = [@tree]
    matching_nodes = []
    while node = queue.pop
      if classes = get_class(node.type)
        classes.each do |cls|
          matching_nodes << node if cls == text
        end
      end
      if children = node.children
        children.each { |child| queue << child}
      end
    end
    matching_nodes
  end

  def get_class(str)
    if pattern = str.match(/class\s?=\s?"(.*?)"/)
      pattern.captures[0].split
    end
  end

  def id(text)
    queue = [@tree]
    matching_nodes = []
    while node = queue.pop
      matching_nodes << node if text == get_id(node.type)
      if children = node.children
        children.each { |child| queue << child}
      end
    end
    matching_nodes
  end

  def get_id(str)
    if pattern = str.match(/id\s?=\s?"(.*?)"/)
      pattern.captures[0]
    end
  end

  def name(text)
    queue = [@tree]
    matching_nodes = []
    while node = queue.pop
      matching_nodes << node if text == get_name(node.type)
      if children = node.children
        children.each { |child| queue << child}
      end
    end
    matching_nodes
  end

  def get_name(str)
    if pattern = str.match(/name\s?=\s?"(.*?)"/)
      pattern.captures[0]
    end
  end

  def text(text)
    queue = [@tree]
    matching_nodes = []
    while node = queue.pop
      matching_nodes << node if text == node.type
      if children = node.children
        children.each { |child| queue << child}
      end
    end
    matching_nodes
  end

end

dom = DomTree.new
file = File.open("test.html", "rb")
contents = file.read
file.close
dom.build_tree(contents)
TreeSearcher.new(dom.document)
#node = searcher.search_by(:class, "top-div")[0]
#NodeRenderer.new(dom.document).render(nil)
dom.render

def is_pangram?(str)
  str_hash = str.each_with_object({}){ |letter, obj| obj[letter] = true}
  ('a'..'z').all? { |letter| str_hash.has_key?(letter) }
end
