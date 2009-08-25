require 'actor'
require 'actor_view'

class ToolbarView < ActorView
  def draw(target, x_off, y_off)
    # paint it gray for now
    target.draw_box_s [x_off+@actor.x,y_off+@actor.y], [x_off+@actor.x+@actor.w,y_off+@actor.y+@actor.h], [50,50,50, 155]
  end
end
class Toolbar < Actor
  has_behavior :layered => 2

  attr_accessor :w, :h
  def setup
    @w = 600
    @h = 160
    button = spawn :button, :x => @x+10, :y => @y+10
  end
end
