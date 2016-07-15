
class DomTree


# p = "<p class='foo bar' id='baz' name='fozzie'>"

# p.match(/[a-z]/)

# "<div id = 'bim'>"

# "<img src='http://www.example.com' title='funny things'>"

  def parse_tag(tag)
    parsed = { "type" => tag.match(/<([a-z]*\d*)\W/).captures,
            "classes" => tag.match(/class='(.*?)'/).captures.split,
                 "id" => "",
               "name" => "" }



     parsed["classes"] =


    #looks for the thing after '<' for type
    #looks for 'class'
    #looks for 'id'
    #looks for 'name'
    #sets all in a hash with keys and values -------
  end

  def classes
  end

  def type
    
  end

  def id

  end

  def name

  end



# tag = parse_tag("<p class='foo bar' id='baz' name='fozzie'>")
# tag.type 
# #=> "p"
# tag.classes 
# #=> ["foo", "bar"]
# tag.id 
# #=> "baz"
# tag.name 
# #=> "fozzie"


end

sfsdfd