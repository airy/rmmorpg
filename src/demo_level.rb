require 'level'

class DemoLevel < Level
  def setup
    @toolbar = create_actor :toolbar, :x => 30, :y => 600
    @toolbar.when :cast_spell do |spell|
        puts "THEY JUST CAST!  [#{spell}]"
	#here there must be a code for sending event to server like
	#$game_client.send_data "casting [#{spell}]"
    end
  end

  def draw(target, x_off, y_off)
    target.fill [25,25,25,255]
  end
end

