require_relative '../action'
require 'uuid'

module ONVIF
    module EventAction
        class Renew < Action
            def run time, cb
              uuid = UUID.new
                message = Message.new namespaces: {
                    #:'xmlns:wsdl' => 'http://www.onvif.org/ver10/events/wsdl',
                    #:'xmlns' => "http://docs.oasis-open.org/wsn/b-2"
                }
                message.head =  ->(xml) do
                  xml.a :Action, 'http://www.onvif.org/ver10/events/wsdl/EventPortType/CreatePullPointSubscriptionRequest'
                  xml.a :MessageID, 'urn:' + 'uuid:' + uuid.generate
                  xml.a(:ReplyTo) do
                    xml.a :Address, 'http://www.w3.org/2005/08/addressing/anonymous'
                  end
                  xml.a :To    , @client.options[:address].to_s
                end
                message.body =  ->(xml) do
                    xml.Renew('xmlns' => 'http://docs.oasis-open.org/wsn/b-2') do
                        xml.TerminationTime time
                    end
                end
                send_message message do |success, result|
                    if success
                        xml_doc = Nokogiri::XML(result[:content])
                        #puts "Renew Result is : ", xml_doc

                        reg = /http\:\/\/\d+\.\d+\.\d+\.\d+\:?\d+?\/\w+\/\w+\/\w+\-\d+\-\w+\:\d+\:\w+/
                        add = reg.match(@client.inspect)

                        res = {}
                        res[:addresses] = add
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

