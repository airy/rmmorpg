require 'helper'
require 'toolbar'

describe 'a new Toolbar' do
  before do 
    opts = {:level=>"level", :input=>"input", :resources=>"resource"}
    @test_me = Toolbar.new opts
  end

  it 'should do something'
end
