require_relative "../lib/ruby_onvif_client"

EM.run do 
    event = ONVIF::Event.new("http://192.168.2.79/onvif/Event", "admin", "12345")
    #event.subscribe
    # event.get_event_service_address ->(address) {
    #     puts "address=",address
        # event.get_event_properties ->(success, result) {
        #     if success
        #         puts "ooooooooooooook"
        #     end
        # }
    #     event.create_pull_point_subscription 'PT10S', ->(success, result) {
    #         if success
    #             puts "ooooooooooooook"
    #         end
    #     }        
    # }
    event.create_pull_point_subscription 'PT10S', ->(success, result) {
        if success
            puts "ooooooooooooook", result
        end
    }     
end