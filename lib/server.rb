#!/usr/bin/ruby
require 'rubygems'
require 'eventmachine'

module GameComm
	include EM::P::ObjectProtocol

	def check_auth data
		data = data.strip
		@username ||= data.split(":")[0]
		@password ||= data.split(":")[1]
		#authentication method will be added
		if @username && @password
			(@@connections ||= []) << self
			puts "authentication ok: #{@username}"
			send_data "welcome #{@username}"
			return true
		else
			puts "authentication failed: #{@username}"
			return false
		end
	end
	
	def receive_data data
		unless @authenticated
			@authenticated ||= check_auth data
			close_connection unless @authenticated	
		else
			puts "incoming data from #{@username}: #{data}"
			@@connections.each do |client|
				client.send_data "#{@username}: #{data}"
			end
		end
	end
end


EventMachine::run do
	EventMachine::start_server "localhost", 8081, GameComm
end

  #command = "xterm -e ruby #{File.dirname(__FILE__)}/../lib/server.rb;sleep 10" 
  #$server = Thread.new { system command}

