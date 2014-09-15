#=======================================================================================
#======================================Show Info========================================
#=======================================================================================
def showDeviceGeneralInfo (device)
    puts
    puts "==============================General_info=============================="
    puts "EndpointReference      : #{device[:ep_address]}"
    puts "Device Types           : #{device[:types]}"
    puts "Device Address         : #{device[:device_ip]}"
    puts "Device Service Address : #{device[:device_service_address]}"
    print "Scopes                 : "
    device[:scopes].each do |sco|
        if sco != device[:scopes][0]
            print " "*25
        end
        puts sco
    end
    puts "Metadata Version       : #{device[:metadata_version]}"
    puts "=============================General_info_End==========================="
end


def showSingleDeviceGeneralInfo (addr, deviceAllList)
    deviceAllList.each do |device|
        if device[:device_ip] == addr
            puts
            puts "==============================General_info=============================="
            puts "EndpointReference      : #{device[:ep_address]}"
            puts "Device Types           : #{device[:types]}"
            puts "Device Address         : #{device[:device_ip]}"
            puts "Device Service Address : #{device[:device_service_address]}"
            print "Scopes                 : "
            device[:scopes].each do |sco|
                if sco != device[:scopes][0]
                    print " "*25
                end
                puts sco
            end
            puts "Metadata Version       : #{device[:metadata_version]}"
            puts "=============================General_info_End==========================="
        end
    end
end



#=======================================================================================
#======================================Save Info========================================
#=======================================================================================
def saveDeviceGeneralInfo (device)
    path = Pathname.new(File.dirname(__FILE__)).realpath
    time = Time.now.strftime("%F %H.%M")
    name = "#{time} Device_Info.txt"
    file = File.new("#{path}/../../DataSave/DeviceInfo/#{name}", "a+")

    file.puts
    file.puts "==============================General_info=============================="
    file.puts "EndpointReference      : #{device[:ep_address]}"
    file.puts "Device Types           : #{device[:types]}"
    file.puts "Device Address         : #{device[:device_ip]}"
    file.puts "Device Service Address : #{device[:device_service_address]}"
    file.print "Scopes                 : "
    device[:scopes].each do |sco|
        if sco != device[:scopes][0]
            file.print " "*25
        end
        file.puts sco
    end
    file.puts "Metadata Version       : #{device[:metadata_version]}"
    file.puts "=============================General_info_End==========================="

    file.close
end


def saveSingleDeviceGeneralInfo (addr, deviceAllList)
    path = Pathname.new(File.dirname(__FILE__)).realpath
    time = Time.now.strftime("%F %H.%M")
    name = "#{time} Device_Info.txt"
    file = File.new("#{path}/../../DataSave/DeviceInfo/#{name}", "a+")

    deviceAllList.each do |device|
        if device[:device_ip] == addr
            file.puts
            file.puts "==============================General_info=============================="
            file.puts "EndpointReference      : #{device[:ep_address]}"
            file.puts "Device Types           : #{device[:types]}"
            file.puts "Device Address         : #{device[:device_ip]}"
            file.puts "Device Service Address : #{device[:device_service_address]}"
            file.print "Scopes                 : "
            device[:scopes].each do |sco|
                if sco != device[:scopes][0]
                    file.print " "*25
                end
                file.puts sco
            end
            file.puts "Metadata Version       : #{device[:metadata_version]}"
            file.puts "=============================General_info_End==========================="
        end
    end
    
    file.close
end