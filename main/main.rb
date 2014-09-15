#!/usr/bin/ruby

require_relative "../lib/em-http"
require_relative "../lib/ruby_onvif_client"
require_relative "ShowInfo/ShowInfo"
require 'pathname'

UserName = "admin"
PassWord = "admin"
$allData  = Hash.new 
$deviceAllList = []

EM.run do
    ONVIF::DeviceDiscovery.start do |device|
        nvs = /Network_Video_Storage/
        if nvs.match(device.inspect) == nil
            $deviceAllList << device
            $deviceList    = device
            serAddr = device[:device_service_address].strip
            ipa     = device[:device_ip].strip
            $allData[ipa] = {:capaResult => nil, :midResult => nil, :uriResult => [], :ptcResult => nil}
            #=======================================================================================
            #=============================Get Device Capabilities Info==============================
            #=======================================================================================
            manage = ONVIF::DeviceManagement.new(serAddr, UserName, PassWord)
            content = [{:Category => 'All'}]
            manage.get_capabilities content, ->(success, capaResult) {
                if success
                    ipAddr = capaResult[:ipa]
                    $allData[ipAddr][:capaResult] = capaResult
                    if capaResult.has_key? :media
                        #=======================================================================================
                        #================================Get Device Media Info==================================
                        #=======================================================================================
                        midAddr = capaResult[:media][:x_addr]
                        media  = ONVIF::Media.new(midAddr, UserName, PassWord)
                        media.GetProfiles ->(success, midResult) {
                            if success
                                ipAddr = midResult[0][:ipa]
                                $allData[ipAddr][:midResult] = midResult
                                midResult.each do |tok|
                                    content = setupContent tok
                                    media.get_stream_uri content, ->(success, uriResult){
                                    if success
                                        ipAddr = uriResult[:ipa]
                                        profileName = tok[:name]
                                        $allData[ipAddr][:uriResult] << uriResult
                                    else
                                        showDeviceStreamURIErrorInfo
                                    end
                                    }
                                end
                            else
                                showDeviceMediaErrorInfo
                            end
                        }
                        #=======================================================================================
                        #================================Get Device Media Info==================================
                        #=======================================================================================
                    end
                else
                    showDeviceCapabilitiesErrorInfo
                end
            }

            #manage.get_network_protocols ->(success, ptcResult) {
            #    if success
            #        ipAddr = ptcResult[0][:ipa]
            #        $allData[ipAddr][:ptcResult] = ptcResult
            #    else
            #        showProtocolErrorInfo
            #    end
            #}
            #========================================================================================
            #==============================Get Device Capabilities Info End==========================
            #========================================================================================
        end
    end

    #========================================================================================
    #======================================Show And Save All Data============================
    #========================================================================================
    EM::PeriodicTimer.new(1) do
        $allData.each do |addr, data|
            if data[:capaResult] != nil && data[:midResult] != nil && data[:uriResult] != nil #&& data[:ptcResult] != nil
                showSingleDeviceGeneralInfo addr, $deviceAllList
                saveSingleDeviceGeneralInfo addr, $deviceAllList
                #showProtocolInfo data[:ptcResult], $deviceList
                #saveProtocolInfo data[:ptcResult], $deviceList
                showDeviceCapabilitiesInfo data[:capaResult]
                saveDeviceCapabilitiesInfo data[:capaResult]
                showDeviceStreamURIInfo data[:uriResult]
                saveDeviceStreamURIInfo data[:uriResult]
                showDeviceMediaInfo data[:midResult]
                saveDeviceMediaInfo data[:midResult]
                $allData.delete(addr)
            end
        end
    end  
end