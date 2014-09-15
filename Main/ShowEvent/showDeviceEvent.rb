#=======================================================================================
#======================================Get Event========================================
#=======================================================================================
def getEventMessage (startTime)
  event = ONVIF::Event.new(Address, UserName, PassWord)
  event.create_pull_point_subscription 'PT60S', ->(success, subResult) {
    if success
      #puts "Create Pull Point Subscription OK"
      event = ONVIF::Event.new(subResult[:addresses][0], UserName, PassWord)
      sleep(5)
      pullMessages event, startTime
    else
      #puts "Get CreatePullPointSubscriptionResponse Fail，restart to CreatePullPointSubscription"
      getEventMessage startTime
    end
  }
end


def pullMessages (event, startTime)
  content = {}
  content[:time_out] = 'PT60S'
  content[:message_limit] = '1'
  event.pull_messages content, ->(success, eventResult) {
    if success
      showDeviceEvent eventResult
      saveDeviceEvent eventResult, startTime
      pullMessages event, startTime
      #renewSubscription event, startTime
      #getEventMessage startTime
      break
    else
      #puts "Get PullMessagesResponse Fail，restart to renewSubscription"
      #renewSubscription event, startTime
      #puts "Get PullMessagesResponse Fail，restart to CreatePullPointSubscription"
      getEventMessage startTime
      break
    end
  }
end


def renewSubscription (event, startTime)
  event.renew 'PT60S', ->(success, result) {
    if success
      puts "Renew Succeed"
      pullMessages event, startTime
    else
      puts "Get RenewResponse Fail，restart to CreatePullPointSubscription"
      getEventMessage startTime
      break
    end
  }
end



#=======================================================================================
#======================================Show Event=======================================
#=======================================================================================
def showDeviceEvent (result)
  puts "Event Addresses    : #{result[:addresses]}"
  puts "Local Tims         : #{Time.now.strftime("%F %H:%M:%S")}"
  puts "Current Time       : #{result[:current_time]}"
  puts "Termination Time   : #{result[:termination_time]}"
  if result.has_key? :topic
    puts "Utc Time           : #{result[:utc_time]}"
    puts "Property Operation : #{result[:property_operation]}"
    #puts "Source             : ", result[:source]
    puts "Data Name          : #{result[:data_name]}"
    puts "Data State         : #{result[:data_value]}"
  end
end



#=======================================================================================
#======================================Save Event=======================================
#=======================================================================================
def saveDeviceEvent (result, startTime)
  path = Pathname.new(File.dirname(__FILE__)).realpath
  time = startTime
  name = "#{time} Device_Event.txt"
  file = File.new("#{path}/../../DataSave/DeviceEvent/#{name}", "a+")

  file.puts "Event Addresses    : #{result[:addresses]}"
  file.puts "Local Tims         : #{Time.now.strftime("%F %H:%M:%S")}"
  file.puts "Current Time       : #{result[:current_time]}"
  file.puts "Termination Time   : #{result[:termination_time]}"
  if result.has_key? :topic
    file.puts "Utc Time           : #{result[:utc_time]}"
    file.puts "Property Operation : #{result[:property_operation]}"
    #file.puts "Source             : ", result[:source]
    file.puts "Data Name          : #{result[:data_name]}"
    file.puts "Data State         : #{result[:data_value]}"
  end
  
  file.close
end