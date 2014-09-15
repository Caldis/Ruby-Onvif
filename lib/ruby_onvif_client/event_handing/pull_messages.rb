require_relative '../action'
require 'uuid'

module ONVIF
    module EventAction
        class PullMessages < Action
            def run options, cb
                uuid = UUID.new
                message = Message.new #namespaces: {:'xmlns:tev' => 'http://www.onvif.org/ver10/events/wsdl'}
                message.head =  ->(xml) do
                  xml.a :Action, 'http://www.onvif.org/ver10/events/wsdl/PullPointSubscription/PullMessagesRequest'
                  xml.a :MessageID, 'urn:' + 'uuid:' + uuid.generate
                  xml.a(:ReplyTo) do
                    xml.a :Address, 'http://www.w3.org/2005/08/addressing/anonymous'
                  end
                  xml.a :To, @client.options[:address].to_s
                end
                message.body =  ->(xml) do
                    xml.PullMessages('xmlns' => 'http://www.onvif.org/ver10/events/wsdl') do
                        xml.Timeout options[:time_out]
                        xml.MessageLimit options[:message_limit]
                    end
                end
                send_message message do |success, result|
                    if success
                        xml_doc = Nokogiri::XML(result[:content])
                        #puts "PullMessages Result is : ", xml_doc

                        res = {}
                        res[:addresses] = @client.options[:address].to_s
                        res[:current_time] = xml_doc.xpath('//tev:CurrentTime').first.content
                        res[:termination_time] = xml_doc.xpath('//tev:TerminationTime').first.content
                        reg = /NotificationMessage/
                        if reg.match(xml_doc.xpath('//wsnt:NotificationMessage').inspect)
                            res[:topic]   = xml_doc.xpath('wsnt:Topic')
                            res[:message] = xml_doc.xpath('//tt:Message')
                            datareg = /(Name)\=\"(\w+)\" (Value)\=\"(\w+)\"/
                            if res.has_key? :message
                                res[:utc_time] = res[:message].attribute('UtcTime')
                                res[:property_operation] = res[:message].attribute('PropertyOperation')
                                res[:source] = res[:message].xpath('//tt:Source')
                                res[:data]  = res[:message].xpath('//tt:Data')
                                res[:data_name]  = datareg.match(res[:data].to_s)[2]
                                res[:data_value] = datareg.match(res[:data].to_s)[4]
                            end
                        end

                        callback cb, success, res
                    else
                        callback cb, success, result
                    end
                end
            end
        end
    end
end

