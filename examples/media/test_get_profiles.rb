require_relative "../../lib/ruby_onvif_client"

EM.run do
    media = ONVIF::Media.new("http://192.168.2.217/onvif/media_service", "admin", "admin12345")
    media.get_profiles ->(success, result) {
    	puts '--------------', result, '============'
    }
end