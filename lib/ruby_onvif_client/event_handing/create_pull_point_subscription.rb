require_relative '../action'
require 'uuid'

module ONVIF
    module EventAction
        class CreatePullPointSubscription < Action
            def run time, cb
              uuid = UUID.new
                message = Message.new namespaces: {
                  #:'xmlns:wsnt'     => 'http://docs.oasis-open.org/wsn/b-2',
                  #:'xmlns:tev'      => 'http://www.onvif.org/ver10/events/wsdl',
                  #:'xmlns:tns1'     => 'http://www.onvif.org/ver10/topics',
                  #:'xmlns:tnsvendor'=> 'http://www.vendor.com/2009/event/topics'
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
                    xml.CreatePullPointSubscription('xmlns' => 'http://www.onvif.org/ver10/events/wsdl') do
                        xml.InitialTerminationTime time
                    end
                end
                #puts "CreatePullPointSubscription Message is : ", message
                send_message message do |success, result|
                    if success
                        xml_doc = Nokogiri::XML(result[:content])
                        #puts "CreatePullPointSubscription Result is : ", xml_doc
                        addresses = []
                        xml_doc.xpath('//tev:SubscriptionReference').each do |node|
                            addresses << value(node, 'wsa:Address')
                        end
                        res = {}
                        res[:addresses] = addresses
                        current_time = xml_doc.xpath('//wsnt:CurrentTime').first.content
                        termination_time = xml_doc.xpath('//wsnt:TerminationTime').first.content
                        res[:current_time] = current_time
                        res[:termination_time] = termination_time
                        callback cb, success, res
                    else
                        callback cb, success, result
                    end
                end
            end
        end
    end
end
