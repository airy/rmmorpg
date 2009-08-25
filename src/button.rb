require 'actor'
require 'actor_view'
require 'publisher'

class ButtonView < ActorView
  def draw(target, x_off, y_off)
    # paint it red for now
    target.draw_box_s [x_off+@actor.x,y_off+@actor.y], [x_off+@actor.x+@actor.w,y_off+@actor.y+@actor.h], [250,0,0, 255]
    if @actor.cooling_down?
      target.draw_box_s [x_off+@actor.x,y_off+@actor.y], [x_off+@actor.x+@actor.w,y_off+@actor.y+@actor.h], [0,0,0, 155]
    end
  end
end

class Button < Actor
  extend Publisher
  can_fire :clicked

  # 2 sec cooldown
  COOLDOWN = 2000

  has_behaviors :updatable,
    :layered => 3

  attr_accessor :w, :h
  def setup
    # register for events here
    # or pull stuff out of @opts
    @w = 60
    @h = 60
    @cooling_down = 0


    i = input_manager
    i.reg MouseDownEvent, :left do |evt|
      unless cooling_down?
        mx = evt.pos[0]
        my = evt.pos[1]
        if @x <= mx && mx <= (@x+@w)
          if @y <= my && my <= (@y+@h)
            @cooling_down = COOLDOWN
            fire :clicked 
          end
        end
      end
    end
  end

  def cooling_down?
    @cooling_down > 0
  end

  def update(delta)
    if cooling_down?
      @cooling_down -= delta
    end
  end
end
