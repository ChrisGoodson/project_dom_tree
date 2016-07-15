
class DomTree
  attr_reader :tag

  def initialize(tag)
    @tag = tag
  end

  def type
    if match = tag.match(/<([a-z]*\d*)\W/)
      match.captures[0]
    end
  end

  def classes
    @tag.match(/class\s?=\s?'(.*?)'/).captures[0].split if tag.match(/class\s?=\s?'(.*?)'/)
  end

  def id
    @tag.match(/id\s?=\s?'(.*?)'/).captures[0] if tag.match(/id\s?=\s?'(.*?)'/)
  end

  def name
    @tag.match(/name\s?=\s?'(.*?)'/).captures[0] if tag.match(/name\s?=\s?'(.*?)'/)
  end

  def title
    @tag.match(/title\s?=\s?'(.*?)'/).captures[0] if tag.match(/title\s?=\s?'(.*?)'/)
  end

  def src
    @tag.match(/src\s?=\s?'(.*?)'/).captures[0] if tag.match(/src\s?=\s?'(.*?)'/)
  end

end

par = DomTree.new("<p class='foo bar' id='baz' name='fozzie'>")
d = DomTree.new("<div id = 'bim'>")
i = DomTree.new("<img src='http://www.example.com' title='funny things'>")

p par.type
p par.classes
p par.id
p par.name

p d.type
p d.classes
p d.id
p d.name

p i.type
p i.classes
p i.id
p i.name
p i.src
p i.title
