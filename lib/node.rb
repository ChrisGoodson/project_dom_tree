Node = Struct.new(:type, :parent, :depth, :children, :attributes) do

  def build_attributes_hash
    att_hash = {}
    attribute_pairs = self.type.scan((/([[a-zA-Z]\d\p{p}]*)\s*=\s*\p{P}([\w\p{Pd}]*)/))
    solo = self.type.scan(/\s(?<!\p{P})([\w*]*)[\s|>]/).flatten
    attribute_pairs.each { |item| att_hash[item[0]] = item[1] }
    self.attributes = att_hash
    solo.each { |item| att_hash[item] = true }
  end

end
