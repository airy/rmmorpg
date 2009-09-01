require 'eventmachine'

module ConnClient
	include EM::P::ObjectProtocol
	
	# Called after the connection with a client has been established
	def connection_completed
		send_data "#{$username}:#{$password}"
	end
	
	def receive_data data
		puts  data
	end
	
	def unbind
		puts "connection has terminated"
		exit
	end
end

module KeyboardHandler
	#for handling the action key presses remove this line and add a buffering method
	include EM::Protocols::LineText2
	
	def initialize(client)
		@client = client
	end
	
	def receive_line(data)
		@client.send_data(data)
	end
end

class GameClient
	attr_accessor :client
	$username = "airy"
	$password = "password"
	def initialize
		EventMachine::run do
			@client = EventMachine::connect "localhost", 8081, ConnClient
			#	EventMachine::open_keyboard(KeyboardHandler, @client)
		end 
	end 
end

Thread.new { $game_client = GameClient.new }
