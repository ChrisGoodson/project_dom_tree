require 'tree_searcher'

describe TreeSearcher do
  let(:tree_search) {TreeSearcher.new("tree")}

  describe '#initialize' do
    it 'returns an instance of TreeSearcher' do
      expect(tree_search).to be_an_instance_of(TreeSearcher)
    end


  end





end