#!/usr/bin/ruby

require_relative "../../lib/em-http"
require_relative "../../lib/ruby_onvif_client"

UserName = "admin"
PassWord = "admin"
Address  = "192.168.2.217"

EM.run do
    ONVIF::DeviceDiscovery.start do |device|
        if device[:device_ip].strip == Address
            puts "#{Address} Found!"
            serAddr= device[:device_service_address].strip
            manage = ONVIF::DeviceManagement.new(serAddr, UserName, PassWord)
            content = [{:Category => 'All'}]
            manage.get_capabilities content, ->(success, capaResult) {
                if success
                    #puts 'Get Media Capabilities Succeed!'
                    midAddr = capaResult[:media][:x_addr]
                    $ptzAddr = capaResult[:ptz][:x_addr]
                    puts "PTZ Address is : #{$ptzAddr}"
                    media  = ONVIF::Media.new(midAddr, UserName, PassWord)
                    media.GetProfiles ->(success, midResult) {
                        if success
                            #puts 'Get Profiles Succeed!'
                            midResult.each do |profile|
                                $token = profile[:token]
                                puts "Meida Token is : #{$token}"
                            end
                        end
                    }
                end
            }
        else
            puts "#{Address} not found!"
        end
    end
end