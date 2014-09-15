#=======================================================================================
#======================================Show Info========================================
#=======================================================================================
def showDeviceCapabilitiesInfo (result)
    puts "===========================Device_Capabilitise_info====================="
    print "Device GetCapabilities Support : "
    result.each do |capName, capData|
        if capName.to_s != "ipa"
            print "#{capName} ".capitalize
        end
    end
    puts
    result.each do |capName, capData|
      if capName.to_s != "ipa"
        puts "#{capName} ".capitalize + " : #{capData[:x_addr]}"
      end
    end
    puts "=========================Device_Capabilitise_info_End==================="
end


def showDeviceCapabilitiesErrorInfo
    puts "===========================Device_Capabilitise_info====================="
    puts "ERROR!  Connection has been close, please check the UserName and Password"
    puts "=========================Device_Capabilitise_info_End==================="
end




#=======================================================================================
#======================================Save Info========================================
#=======================================================================================
def saveDeviceCapabilitiesInfo (result)
    path = Pathname.new(File.dirname(__FILE__)).realpath
    time = Time.now.strftime("%F %H.%M")
    name = "#{time} Device_Info.txt"
    file = File.new("#{path}/../../DataSave/DeviceInfo/#{name}", "a+")

    file.puts "===========================Device_Capabilitise_info====================="
    file.print "Device GetCapabilities Support : "
    result.each do |capName, capData|
        if capName.to_s != "ipa"
            file.print "#{capName} ".capitalize
        end
    end
    file.puts
    file.puts "=========================Device_Capabilitise_info_End==================="

    file.close
end

def saveDeviceCapabilitiesErrorInfo
    path = Pathname.new(File.dirname(__FILE__)).realpath
    time = Time.now.strftime("%F %H.%M")
    name = "#{time} Device_Info.txt"
    file = File.new("#{path}/../../DataSave/DeviceInfo/#{name}", "a+")

    file.puts "===========================Device_Capabilitise_info====================="
    file.puts "ERROR!  Connection has been close, please check the UserName and Password"
    file.puts "=========================Device_Capabilitise_info_End==================="

    file.close
end