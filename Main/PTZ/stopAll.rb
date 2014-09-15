def stopAll (ptz, token)
  	content = {
      	:profile_token => token,
      	:pantilt => 'ture',
      	:zoom => 'ture'
  	}
  	ptz.stop content, ->(success, result) {
  		puts 'Stop All Succeed'
    	#puts result
  	}
end