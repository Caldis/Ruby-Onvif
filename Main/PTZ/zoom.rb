def zoom (ptz, token, x, timeout = 1)
    content = {
        :profile_token => token,
        :velocity => {
            :zoom => {
                :x => x,
                :xmlns => "http://www.onvif.org/ver10/schema"
            }
        },
        #:timeout => timeout
    }
    ptz.continuous_move content, ->(success, result) {
        puts 'Zoom Succeed'
        sleep timeout
        stopZoom ptz, token
    }
end