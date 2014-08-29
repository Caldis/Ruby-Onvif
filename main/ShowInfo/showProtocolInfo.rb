#=======================================================================================
#======================================Show Info========================================
#=======================================================================================
def showProtocolInfo (result, deviceList)
    puts "===============================Protocol_info============================"
    result.each do |pto|
        puts "Protocol Name   : #{pto[:name]}"
        puts "Protocol status : #{pto[:enabled]}"
        puts "Protocol Port   : #{pto[:port]}"
        #puts pto[:extension]
        puts "========================================================================" unless pto == result[result.count - 1]
    end
    puts "==============================Protocol_info_End========================="
end


def showProtocolErrorInfo
    puts "==============================Protocol_info_End========================="
    puts "ERROR!  Connection has been close, please check the UserName and Password"
    puts "==============================Protocol_info_End========================="
end




#=======================================================================================
#======================================Save Info========================================
#=======================================================================================
def saveProtocolInfo (result, deviceList)
    path = Pathname.new(File.dirname(__FILE__)).realpath
    time = Time.now.strftime("%F %H.%M")
    name = "#{time} Device_Info.txt"
    file = File.new("#{path}/../../DataSave/#{name}", "a+")

    file.puts "===============================Protocol_info============================"
    result.each do |pto|
        file.puts "Protocol Name   : #{pto[:name]}"
        file.puts "Protocol status : #{pto[:enabled]}"
        file.puts "Protocol Port   : #{pto[:port]}"
        #file.puts pto[:extension]
        file.puts "========================================================================" unless pto == result[result.count - 1]
    end
    file.puts "==============================Protocol_info_End========================="

    file.close
end


def saveProtocolErrorInfo
    path = Pathname.new(File.dirname(__FILE__)).realpath
    time = Time.now.strftime("%F %H.%M")
    name = "#{time} Device_Info.txt"
    file = File.new("#{path}/../../DataSave/#{name}", "a+")

    file.puts "==============================Protocol_info_End========================="
    file.puts "ERROR!  Connection has been close, please check the UserName and Password"
    file.puts "==============================Protocol_info_End========================="

    file.close
end