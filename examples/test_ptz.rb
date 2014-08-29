require_relative "../lib/ruby_onvif_client"

EM.run do
    media = ONVIF::Ptz.new("http://192.168.2.79/onvif/ptz_service", "admin", "12345")
    media.GetNodes ->(success, result) {
        puts result
    }
end