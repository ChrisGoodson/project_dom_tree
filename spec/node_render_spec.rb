require 'spec_helper'
require 'node_render'

describe NodeRenderer do
  let(:node_render) { NodeRenderer.new("tree")}

  
  describe '#intialize' do
    it 'returns an instance of NodeRenderer' do
      expect(node_render).to be_an_instance_of(NodeRenderer)
    end

    it 'takes one argument' do
      expect{node_render}.to_not raise_error
    end


  end

  
end