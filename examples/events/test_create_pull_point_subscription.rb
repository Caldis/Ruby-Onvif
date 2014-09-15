require_relative "../../lib/ruby_onvif_client"

EM.run do
    get_event_service_address "192.168.2.79", ->(address) {
        puts "address=",address
        event = ONVIF::Event.new(address)
        event.create_pull_point_subscription 'PT10S', ->(success, result) {
            if success
                puts "ooooooooooooook", result
            end
        }      
    }    
   
end