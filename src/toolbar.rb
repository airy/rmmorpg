require 'actor'
require 'actor_view'
require 'publisher'

class ToolbarView < ActorView
  def draw(target, x_off, y_off)
    # paint it gray for now
    target.draw_box_s [x_off+@actor.x,y_off+@actor.y], [x_off+@actor.x+@actor.w,y_off+@actor.y+@actor.h], [50,50,50, 155]
  end
end
class Toolbar < Actor
  extend Publisher
  can_fire :cast_spell

  has_behavior :layered => 2

  attr_accessor :w, :h
  def setup
    @w = 600
    @h = 160
    button_width = 70
    button_height = 70

    button = spawn :button, :x => @x+10, :y => @y+10, :name => "WIN", :w => button_width, :h => button_height, :cooldown => 2000
    button.when :clicked do
      fire :cast_spell, :win
    end

    button = spawn :button, :x => @x+button_width+20, :y => @y+10, :name => "LOSE", :w => button_width, :h => button_height, :cooldown => 3000
    button.when :clicked do
      fire :cast_spell, :lose
    end
  end
end
