require_relative '../action'

module ONVIF
    module PtzAction
        class ContinuousMove < Action
            def run options, cb
                message = create_ptz_onvif_message namespaces: {:'xmlns:sch' => 'http://www.onvif.org/ver10/schema'}
                message.body =  ->(xml) do
                    xml.ContinuousMove('xmlns' => 'http://www.onvif.org/ver20/ptz/wsdl') do
                        xml.ProfileToken options[:profile_token]
                        xml.Velocity do
                            unless options[:velocity][:pan_tilt].nil?
                                xml.PanTilt(
                                    "x" => options[:velocity][:pan_tilt][:x],
                                    "y" => options[:velocity][:pan_tilt][:y],
                                    "xmlns" => options[:velocity][:pan_tilt][:xmlns]
                                )
                            end
                            unless options[:velocity][:zoom].nil?
                              xml.Zoom(
                                  "x" => options[:velocity][:zoom][:x],
                                  "xmlns" => options[:velocity][:zoom][:xmlns]
                              )
                            end
                        end
                        xml.wsdl :Timeout, options[:timeout] unless options[:timeout].nil?
                    end
                end
                send_message message do |success, result|
                    callback cb, success, result
                end
            end
        end
    end
end