require_relative '../action'

module ONVIF
    module PtzAction
        class Stop < Action
            def run options ,cb
                message = create_ptz_onvif_message
                message.body =  ->(xml) do
                    xml.Stop('xmlns' => 'http://www.onvif.org/ver20/ptz/wsdl') do
                        xml.ProfileToken options[:profile_token]
                        xml.PanTilt options[:pantilt]
                        xml.Zoom options[:zoom]
                    end
                end
                send_message message do |success, result|
                    if success
                        #xml_doc = Nokogiri::XML(result[:content])
                        #preset_token = value(xml_doc, '//tptz:PresetToken')
                        #callback cb, success, preset_token
                        callback cb, success, result
                    else
                        callback cb, success, result
                    end
                end
            end
        end
    end
end
