#=======================================================================================
#======================================Show Info========================================
#=======================================================================================
def showDeviceMediaInfo (result)
	puts "============================Device_Media_info==========================="
	result.each do |source|
	    puts "Stream  Name                  : #{source[:name]}"
	    puts "Profile Name                  : #{source[:token]}"

	    if source.has_key? :video_source_configuration
		    puts "Video Source Configuration "
		    puts "    Configuration Name        : #{source[:video_source_configuration][:name]}"
		    puts "    Configuration Token       : #{source[:video_source_configuration][:token]}"
		    puts "    Source Use Conut          : #{source[:video_source_configuration][:use_count]}"
		    puts "    Source Token              : #{source[:video_source_configuration][:source_token]}"
		    if source[:video_source_configuration].has_key? :bounds
		    	puts "    Source Resolution Width   : #{source[:video_source_configuration][:bounds][:width]}"
		    	puts "    Source Resolution Height  : #{source[:video_source_configuration][:bounds][:height]}"
			end
		end

		if source.has_key? :video_encoder_configuration
		    puts "Video Encoder Configuration "
		    puts "    Configuration Name        : #{source[:video_encoder_configuration][:name]}"
		    puts "    Configuration Token       : #{source[:video_encoder_configuration][:token]}"
		    puts "    Encoder Use Conut         : #{source[:video_encoder_configuration][:use_count]}"
		    puts "    Encoding                  : #{source[:video_encoder_configuration][:encoding]}"
		    puts "    Video Quality             : #{source[:video_encoder_configuration][:quality]}"
		   	puts "    Session Timeout           : #{source[:video_encoder_configuration][:session_timeout]}"
		    if source[:video_encoder_configuration].has_key? :resolution
			    puts "    Encoder Resolution Width  : #{source[:video_encoder_configuration][:resolution][:width]}"
			    puts "    Encoder Resolution Height : #{source[:video_encoder_configuration][:resolution][:height]}"
			end
			if source[:video_encoder_configuration].has_key? :rate_control
			    puts "    Frame Rate limit          : #{source[:video_encoder_configuration][:rate_control][:frame_rate_limit]}"
			    puts "    Encoding Interval         : #{source[:video_encoder_configuration][:rate_control][:encoding_interval]}"
			    puts "    Bitrate Limit             : #{source[:video_encoder_configuration][:rate_control][:bitrate_limit]}"
			end
			if source[:video_encoder_configuration].has_key? :H264
			    puts "    Gov Length                : #{source[:video_encoder_configuration][:H264][:gov_length]}"
			    puts "    H264 Profile              : #{source[:video_encoder_configuration][:H264][:h264_profile]}"
			end
			if source[:video_encoder_configuration].has_key? :multicast
				if source[:video_encoder_configuration][:multicast].has_key? :address
					puts "    Type                      : #{source[:video_encoder_configuration][:multicast][:address][:type]}"
					puts "    Multicast Address         : #{source[:video_encoder_configuration][:multicast][:address][:ipv4_address]}"
				end
			    puts "    Pott                      : #{source[:video_encoder_configuration][:multicast][:port]}"
			    puts "    TTL                       : #{source[:video_encoder_configuration][:multicast][:ttl]}"
			    puts "    Auto Start Status         : #{source[:video_encoder_configuration][:multicast][:auto_start]}"
			end
		end

		if source.has_key? :video_analytics_configuration
		    puts "Video Analytics Configuration "
		    puts "    Configuration Name        : #{source[:video_analytics_configuration][:name]}"
		    puts "    Configuration Token       : #{source[:video_analytics_configuration][:token]}"
		    puts "    Analytice Use Count       : #{source[:video_analytics_configuration][:use_count]}"
		    if source[:video_analytics_configuration][:analytics_engine_configuration].has_key? :analytics_module
			    source[:video_analytics_configuration][:analytics_engine_configuration][:analytics_module].each do |mod|
			        puts "    Analytics Module Name     : #{mod[:name]}"
			        puts "    Analytics Module Type     : #{mod[:type]}"
			    end
			end
		end
	    puts "========================================================================" unless source == result[result.count - 1]
	end
	puts "============================Device_Media_info_End======================="
end


def showDeviceMediaErrorInfo
	puts "==============================Device_Media_info========================="
	puts "ERROR!  Connection has been close, please check the UserName and Password"
	puts "============================Device_Media_info_End======================="
end


def deviceStreamURIInfo (midResult, media)
	midResult.each do |tok|
	    content = setupContent tok
	    media.get_stream_uri content, ->(success, uriResult){
	    if success
	        showDeviceStreamURIInfo uriResult
	        saveDeviceStreamURIInfo uriResult
	    else
	        showDeviceStreamURIErrorInfo
	        saveDeviceStreamURIErrorInfo
	    end
	    }
	end 
end


def setupContent (tok)
	content = {
        :stream_setup => {
            :stream => "RTP-Unicast", #'RTP-Unicast', 'RTP-Multicast'
            :transport => {
                :protocol => "RTSP" #UDP TCP HTTP RTSP
            }
        },
        :profile_token => tok[:token]
    }
    return content
end

def showDeviceStreamURIInfo (result)
	result.each do |uri|
	    if uri.has_key? :media_uri
	        puts "=============================Stream_URI_Info============================"
	        puts "Stream URI : #{uri[:media_uri][:uri]}"
	        puts "===========================Stream_URI_Info_End=========================="
	    end
	end
end

def showDeviceStreamURIErrorInfo
	puts "=============================Stream_URI_Info============================"
    puts "Stream URI : ERROR !  This profile has no StreamURI"
    puts "===========================Stream_URI_Info_End=========================="
end



#=======================================================================================
#======================================Save Info========================================
#=======================================================================================
def saveDeviceMediaInfo (result)
    path = Pathname.new(File.dirname(__FILE__)).realpath
    time = Time.now.strftime("%F %H.%M")
    name = "#{time} Device_Info.txt"
    file = File.new("#{path}/../../DataSave/#{name}", "a+")

	file.puts "============================Device_Media_info==========================="
	result.each do |source|
	    file.puts "Stream  Name                  : #{source[:name]}"
	    file.puts "Profile Name                  : #{source[:token]}"

	    if source.has_key? :video_source_configuration
		    file.puts "Video Source Configuration "
		    file.puts "    Configuration Name        : #{source[:video_source_configuration][:name]}"
		    file.puts "    Configuration Token       : #{source[:video_source_configuration][:token]}"
		    file.puts "    Source Use Conut          : #{source[:video_source_configuration][:use_count]}"
		    file.puts "    Source Token              : #{source[:video_source_configuration][:source_token]}"
		    if source[:video_source_configuration].has_key? :bounds
		    	file.puts "    Source Resolution Width   : #{source[:video_source_configuration][:bounds][:width]}"
		    	file.puts "    Source Resolution Height  : #{source[:video_source_configuration][:bounds][:height]}"
			end
		end

		if source.has_key? :video_encoder_configuration
		    file.puts "Video Encoder Configuration "
		    file.puts "    Configuration Name        : #{source[:video_encoder_configuration][:name]}"
		    file.puts "    Configuration Token       : #{source[:video_encoder_configuration][:token]}"
		    file.puts "    Encoder Use Conut         : #{source[:video_encoder_configuration][:use_count]}"
		    file.puts "    Encoding                  : #{source[:video_encoder_configuration][:encoding]}"
		    file.puts "    Video Quality             : #{source[:video_encoder_configuration][:quality]}"
		   	file.puts "    Session Timeout           : #{source[:video_encoder_configuration][:session_timeout]}"
		    if source[:video_encoder_configuration].has_key? :resolution
			    file.puts "    Encoder Resolution Width  : #{source[:video_encoder_configuration][:resolution][:width]}"
			    file.puts "    Encoder Resolution Height : #{source[:video_encoder_configuration][:resolution][:height]}"
			end
			if source[:video_encoder_configuration].has_key? :rate_control
			    file.puts "    Frame Rate limit          : #{source[:video_encoder_configuration][:rate_control][:frame_rate_limit]}"
			    file.puts "    Encoding Interval         : #{source[:video_encoder_configuration][:rate_control][:encoding_interval]}"
			    file.puts "    Bitrate Limit             : #{source[:video_encoder_configuration][:rate_control][:bitrate_limit]}"
			end
			if source[:video_encoder_configuration].has_key? :H264
			    file.puts "    Gov Length                : #{source[:video_encoder_configuration][:H264][:gov_length]}"
			    file.puts "    H264 Profile              : #{source[:video_encoder_configuration][:H264][:h264_profile]}"
			end
			if source[:video_encoder_configuration].has_key? :multicast
				if source[:video_encoder_configuration][:multicast].has_key? :address
					file.puts "    Type                      : #{source[:video_encoder_configuration][:multicast][:address][:type]}"
					file.puts "    Multicast Address         : #{source[:video_encoder_configuration][:multicast][:address][:ipv4_address]}"
				end
			    file.puts "    Pott                      : #{source[:video_encoder_configuration][:multicast][:port]}"
			    file.puts "    TTL                       : #{source[:video_encoder_configuration][:multicast][:ttl]}"
			    file.puts "    Auto Start Status         : #{source[:video_encoder_configuration][:multicast][:auto_start]}"
			end
		end

		if source.has_key? :video_analytics_configuration
		    file.puts "Video Analytics Configuration "
		    file.puts "    Configuration Name        : #{source[:video_analytics_configuration][:name]}"
		    file.puts "    Configuration Token       : #{source[:video_analytics_configuration][:token]}"
		    file.puts "    Analytice Use Count       : #{source[:video_analytics_configuration][:use_count]}"
		    if source[:video_analytics_configuration][:analytics_engine_configuration].has_key? :analytics_module
			    source[:video_analytics_configuration][:analytics_engine_configuration][:analytics_module].each do |mod|
			        file.puts "    Analytics Module Name     : #{mod[:name]}"
			        file.puts "    Analytics Module Type     : #{mod[:type]}"
			    end
			end
		end
	    file.puts "========================================================================" unless source == result[result.count - 1]
	end
	file.puts "============================Device_Media_info_End======================="

	file.close
end


def saveDeviceMediaErrorInfo
    path = Pathname.new(File.dirname(__FILE__)).realpath    
    time = Time.now.strftime("%F %H.%M")
    name = "#{time} Device_Info.txt"
    file = File.new("#{path}/../../DataSave/#{name}", "a+")

	file.puts "============================Device_Media_info==========================="
	file.puts "ERROR!  Connection has been close, please check the UserName and Password"
	file.puts "==========================Device_Media_info_End========================="

	file.close
end


def saveDeviceStreamURIInfo (result)
	path = Pathname.new(File.dirname(__FILE__)).realpath    
    time = Time.now.strftime("%F %H.%M")
    name = "#{time} Device_Info.txt"
    file = File.new("#{path}/../../DataSave/#{name}", "a+")

    result.each do |uri|
	    if uri.has_key? :media_uri
	        file.puts "=============================Stream_URI_Info============================"
	        file.puts "Stream URI : #{uri[:media_uri][:uri]}"
	        file.puts "===========================Stream_URI_Info_End=========================="
	    end
	end

    file.close
end


def saveDeviceStreamURIErrorInfo
	path = Pathname.new(File.dirname(__FILE__)).realpath    
    time = Time.now.strftime("%F %H.%M")
    name = "#{time} Device_Info.txt"
    file = File.new("#{path}/../../DataSave/#{name}", "a+")

	file.puts "=============================Stream_URI_Info============================"
    file.puts "Stream URI : ERROR !  This profile has no StreamURI"
    file.puts "===========================Stream_URI_Info_End=========================="

    file.close
end