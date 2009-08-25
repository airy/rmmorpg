require 'actor'
require 'actor_view'

class ButtonView < ActorView
  def draw(target, x_off, y_off)
    # paint it red for now
    target.draw_box_s [x_off+@actor.x,y_off+@actor.y], [x_off+@actor.x+@actor.w,y_off+@actor.y+@actor.h], [250,0,0, 255]
  end
end

class Button < Actor
  attr_accessor :w, :h
  def setup
    # register for events here
    # or pull stuff out of @opts
    @w = 60
    @h = 60


    i = input_manager
    i.reg MouseDownEvent, :left do |evt|
      mx = evt.pos[0]
      my = evt.pos[1]
      if @x <= mx && mx <= (@x+@w)
        if @y <= my && my <= (@y+@h)
          puts "clicked"
        end
      end
    end
  end
end
