require 'level'
class DemoLevel < Level
  def setup
    @toolbar = create_actor :toolbar, :x => 30, :y => 600
  end

  def draw(target, x_off, y_off)
    target.fill [25,25,25,255]
  end
end

