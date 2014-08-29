require_relative "../../lib/ruby_onvif_client"

EM.run do
    device = ONVIF::Media.new("http://192.168.2.79/onvif/Media","admin", "12345")
    content = {
    	:stream_setup => {
    		:stream => "RTP-Unicast", #'RTP-Unicast', 'RTP-Multicast'
    		:transport => {
    			:protocol => "HTTP" #UDP TCP HTTP RTSP
    		}
    	},
    	:profile_token => "Profile_3"
    }
    device.get_stream_uri content, ->(success, result) {
    	puts '--------------', result, '============'
    }
end