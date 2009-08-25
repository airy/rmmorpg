require 'actor'

class Toolbar < Actor
  def setup
    # register for events here
    # or pull stuff out of @opts
    button = spawn :button, :x => @x+10, :y => @y+10
  end
end
