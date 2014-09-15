def continueMove (ptz, token, x, y, timeout = 5)
    content = {
        :profile_token => token,
        :velocity => {
            :pan_tilt => {
                :x => x,
                :y => y,
                :xmlns => 'http://www.onvif.org/ver10/schema'
            }
        },
        #:timeout => timeout
    }
    ptz.continuous_move content, ->(success, result) {
        puts 'Move Succeed'
        sleep timeout
        stopContinueMove ptz, token
    }
end