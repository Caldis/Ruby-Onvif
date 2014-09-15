require_relative "../lib/ruby_onvif_client"

EM.run do 
    address = "http://192.168.2.79/onvif/Events"
    event = ONVIF::Event.new(address, "admin", "12345")
    event.create_pull_point_subscription 'PT20S', ->(success, result) {
        if success
            #puts "create_pull_point_subscription OK", result
            event = ONVIF::Event.new(result[:addresses][0], "admin", "12345")
            content = {}
            content[:time_out] = 'PT20S'
            content[:message_limit] = '1'
            event.pull_messages content, ->(success, result) {
                if success
                    puts "Pull Messages OK"
                    puts "Event Addresses    : #{result[:addresses]}"
                    puts "Current Time       : #{result[:current_time]}"
                    puts "Termination Time   : #{result[:termination_time]}"
                    puts "Utc Time           : #{result[:utc_time]}"
                    puts "Property Operation : #{result[:property_operation]}"
                    #puts "Source             : ", result[:source]
                    puts "Data Name          : #{result[:data_name]}"
                    puts "Data State         : #{result[:data_value]}"
                else
                    puts "Pull Messages ERROR"
                end
            }
        else
            puts "Create Pull Point Subscription ERROR"
        end
    }
end