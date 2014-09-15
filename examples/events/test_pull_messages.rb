require_relative "../../lib/ruby_onvif_client"
require_relative "../../main/ShowEvent/ShowEvent"

UserName = "admin"
PassWord = "12345"
Address  = "http://192.168.2.79/onvif/Events/PullSubManager_2014-09-03T09:18:10Z_8"

EM.run do
    event = ONVIF::Event.new(Address, UserName, PassWord)
    content = {}
    content[:time_out] = 'PT5M'
    content[:message_limit] = '10'
    event.pull_messages content, ->(success, result) {
      if success
        showDeviceEvent result
      else
        puts "Pull Messages ERROR"
        puts result
      end
    }
end