require_relative "../../lib/ruby_onvif_client"
require_relative "../../lib/ruby_onvif_client/server.rb"

UserName  = "admin"
PassWord  = "12345"
Addr      = "http://192.168.2.79/onvif/Events"
StartTime = Time.now.strftime("%F %H.%M.%S")

EM.run do
  	cb = ->(res) {
        puts "Res is : ",res
  	}

  	EM::start_server("0.0.0.0", 8081, ONVIF::Server, cb) do |conn|
  		  conn.instance_eval do
  			  puts "@HTTP Content is : ",@http_content
  	    end
  	end

    get_event_service_address "192.168.2.79:8080", ->(address) {
        puts "Service Address is: #{address}"
        content = {}
        content[:address] = 'http://192.168.2.79:8080/onvif_notify_server'
        content[:initial_termination_time] = 'PT10S'
        event = ONVIF::Event.new(address, UserName, PassWord)
        event.subscribe content, ->(success, result) {
            if success
                puts "Subscribe Result is : ", result
                event.set_synchronization_point ->(success, result) {
                  if success
                    puts "Set Synchronization Point is : ", result
                  end
                }
            end
        }
    }
end