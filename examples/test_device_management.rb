require_relative "../lib/ruby_onvif_client"

EM.run do
    device_management = ONVIF::DeviceManagement.new("http://192.168.2.79/onvif/device_service", 'admin', '12345')
    device_management.get_network_protocols ->(success, result) {
    	reg = /\"CONNECTION\"\=\>\"close\"/
    	if reg.match(result.inspect) != nil
    		#puts "Device not found, please ensure the device has connect in Local Network"
    		puts "ERROR!  Connection has been close, please check the UserName and Password"
    	else
	        result.each do |stream|
	        	print "==============================", stream[:name] 
	        	puts "_Protocol_info======================="
	        	print "Protocol Name   : "
	        	puts stream[:name]
	        	print "Protocol status : "
	        	puts stream[:enabled]
	        	print "Protocol Port   : "
	        	puts stream[:port]
	        	#puts stream[:extension]
	        	print "============================",stream[:name] 
                puts "_Protocol_info_End======================"
	        end
	    end
    }
end




		device_management = ONVIF::DeviceManagement.new(serAddr, UserName, UserName)
        device_management.get_network_protocols ->(success, result) {
        if success
            result.each do |stream|
                puts "============================#{stream[:name]}_Protocol_info=========================="
                print "Protocol Name   : "
                puts stream[:name]
                print "Protocol status : "
                puts stream[:enabled]
                print "Protocol Port   : "
                puts stream[:port]
                #puts stream[:extension]
                if stream[:name] == 'RTSP' && stream[:enabled] == 'true'
                    print "Protocol Addr   : "
                    puts "rtsp://" + device[:device_ip] + ":" + stream[:port]
                end
                print "============================#{stream[:name]}_Protocol_info_End======================"
            end
        else
            #puts "Device not found, please ensure the device has connect in Local Network"
            puts "ERROR!  Connection has been close, please check the UserName and Password"
        end
        }