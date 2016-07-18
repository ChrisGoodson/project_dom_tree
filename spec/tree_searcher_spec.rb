require 'tree_searcher'

describe TreeSearcher do
  let(:tree_search) {TreeSearcher.new("tree")}
  let(:dom_tree) { DomTree.new }
  let (:test_html) { "<div class=\"test\">
                          div text before
                            <p>
                              p text
                            </p>
                            <div>
                              more div text
                            </div>
                          div text after
                        </div>" 
                      }



  describe '#initialize' do
    it 'returns an instance of TreeSearcher' do
      expect(tree_search).to be_an_instance_of(TreeSearcher)
    end

  end

  describe '#search_by' do
    it 'returns all matching nodes' do
      dom_tree.build_tree(test_html)
      search = TreeSearcher.new(dom_tree.document)
      expect(search.search_by(:class, 'test')[0]).to be_a(Node)
    end



    end



end