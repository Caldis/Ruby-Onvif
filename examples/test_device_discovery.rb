require_relative "../lib/ruby_onvif_client"

EM.run do
    ONVIF::DeviceDiscovery.start do |device|
        puts
        puts "==============================Device_info=============================="
        print "EndpointReference      : "
        puts device[:ep_address]
        print "Device Types           : "
        puts device[:types]
        print "Device Address         : "
        puts device[:device_ip]
        print "Device Service Address : "
        puts device[:device_service_address]
        print "Scopes                 : "
        device[:scopes].each do |sco|
            if sco != device[:scopes][0]
                print " "*25
            end
            puts sco
        end
        print "Metadata Version       : "
        puts device[:metadata_version]
        puts "======================================================================="
    end
end

