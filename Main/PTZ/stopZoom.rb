def stopZoom (ptz, token)
  	content = {
      	:profile_token => token,
      	:pantilt => 'false',
      	:zoom => 'true'
  	}
  	ptz.stop content, ->(success, result) {
  		puts 'Stop Zoom Succeed'
    	#puts result
  	}
end