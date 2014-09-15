def stopContinueMove (ptz, token)
  	content = {
      	:profile_token => token,
      	:pantilt => 'true',
      	:zoom => 'false'
  	}
  	ptz.stop content, ->(success, result) {
  		puts 'Stop ContinueMove Succeed'
      	#puts result
  	}
end