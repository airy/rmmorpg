require 'actor'
require 'actor_view'
require 'publisher'

class ButtonView < ActorView
  def setup
    @font = @actor.resource_manager.load_font 'porky.ttf', 30
    @image = @font.render @actor.name, true, [250,250,250]
  end

  def draw(target, x_off, y_off)
    # paint it red for now
    x = x_off+@actor.x
    y = y_off+@actor.y
    target.draw_box_s [x,y], [x+@actor.w,y+@actor.h], [250,0,0, 255]

    @image.blit target.screen, [x,y]
    
    if @actor.cooling_down?
      scale = @actor.cooling_down/@actor.default_cooldown.to_f
      cool_h = @actor.h*scale
      cool_w = @actor.w*scale
      start_x = x+((@actor.w-cool_w)/2.0)
      start_y = y+((@actor.h-cool_h)/2.0)
      target.draw_box_s [start_x,start_y], [start_x+cool_w,start_y+cool_h], [0,0,0, 155]
    end
  end
end

class Button < Actor
  extend Publisher
  can_fire :clicked

  has_behaviors :updatable,
    :layered => 3

  attr_accessor :w, :h, :name, :cooling_down, :default_cooldown
  def setup
    # register for events here
    # or pull stuff out of @opts
    @w = @opts[:w]
    @h = @opts[:h]
    @cooling_down = 0
    @default_cooldown = @opts[:cooldown]
    @name = @opts[:name]


    i = input_manager
    i.reg MouseDownEvent, :left do |evt|
      unless cooling_down?
        mx = evt.pos[0]
        my = evt.pos[1]
        if @x <= mx && mx <= (@x+@w)
          if @y <= my && my <= (@y+@h)
            @cooling_down = @default_cooldown
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
