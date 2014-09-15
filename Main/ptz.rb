#!/usr/bin/ruby

require_relative "../lib/em-http"
require_relative "../lib/ruby_onvif_client"
require_relative "PTZ/move"

UserName = "admin"
PassWord = "admin"
Address  = "http://192.168.2.217:80/onvif/ptz_service"
Token    = "profile_CIF"

EM.run do
    ptz = ONVIF::Ptz.new(Address, UserName, PassWord)
    continueMove ptz, Token, 1, 1
    #stopContinueMove ptz, Token
    #zoom ptz, Token, 0.2
    #stopZoom ptz, Token
    #stopAll ptz, Token
end