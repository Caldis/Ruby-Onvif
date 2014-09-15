#!/usr/bin/ruby

require_relative "../lib/em-http"
require_relative "../lib/ruby_onvif_client/server"
require_relative "../lib/ruby_onvif_client"
require_relative "ShowEvent/ShowEvent"
require 'pathname'

UserName  = "admin"
PassWord  = "12345"
Address   = "http://192.168.2.79:8080/onvif/Events"
StartTime = Time.now.strftime("%F %H.%M.%S")

EM.run do
    getEventMessage StartTime
end