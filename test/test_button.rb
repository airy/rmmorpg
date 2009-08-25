require 'helper'
require 'button'

describe 'a new Button' do
  before do 
    opts = {:level=>"level", :input=>"input", :resources=>"resource"}
    @test_me = Button.new opts
  end

  it 'should do something'
end
