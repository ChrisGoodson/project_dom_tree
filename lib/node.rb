Node = Struct.new(:type, :parent, :depth, :children, :attributes) do

  def build_attributes_hash
    att_hash = {}
    attribute_pairs = self.type.scan((/([[a-zA-Z]\d\p{p}]*)\s*=\s*\"([[a-zA-Z]\p{Pd}\s*]*)"/))
    solo = self.type.scan(/[[a-zA-Z]\d\p{p}]*\s*=\s*\"[[a-zA-Z]\p{Pd}\s*]*"|\s(?<!p{P}\s)([\w*]*)[\s|>]/).flatten
    attribute_pairs.each do |item|
      item[1] = item[1].split(" ")
      att_hash[item[0]] = item[1]
    end
    solo.each { |item| att_hash[item] = true unless item.nil?}
    self.attributes = att_hash
  end

end
