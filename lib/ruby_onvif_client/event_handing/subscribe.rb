require_relative '../action'

module ONVIF
    module EventAction
        class Subscribe < Action
            def run options, cb
                message = Message.new namespaces: {:'xmlns:wsdl' => 'http://www.onvif.org/ver10/events/wsdl', :'xmlns:a' => "http://www.w3.org/2005/08/addressing", 'xmlns:b' => "http://docs.oasis-open.org/wsn/b-2"}
                message.body =  ->(xml) do
                    xml.b(:Subscribe) do
                        xml.b(:ConsumerReference) do
                            xml.a :Address, options[:address]
                        end
                        xml.b :InitialTerminationTime , options[:initial_termination_time]
                    end
                end
                send_message message do |success, result|
                    if success
                        xml_doc = Nokogiri::XML(result[:content])
                        addresses = []
                        xml_doc.xpath('//tev:SubscriptionReference').each do |node|
                            addresses << value(node, 'wsa:Address')
                        end                        
                        res = {}
                        puts addresses
                        res[:addresses] = addresses
                        res[:current_time] = xml_doc.xpath('//wsnt:CurrentTime').first.content
                        res[:termination_time] = xml_doc.xpath('//wsnt:TerminationTime').first.content
                        callback cb, success, res
                    else
                        callback cb, success, result
                    end
                end
            end
        end
    end
end

 # <Subscribe xmlns="http://docs.oasis-open.org/wsn/b-2">
 #      <ConsumerReference>
 #        <a:Address>http://192.168.16.197/onvif_notify_server</a:Address>
 #      </ConsumerReference>
 #      <InitialTerminationTime>PT10S</InitialTerminationTime>
 #    </Subscribe>