require 'aws-sdk-ses'
require './src/aws/credential'

module Aws
  class SESClient
    def initialize(region)
      @region = region
    end

    def client
      @client ||= Aws::SES::Client.new(
        region: @region,
        credentials: Credential.credentials,
      )
    end

    def send(to_addresses, from_address, text_messages)
      parameters = {
        destination: {
          to_addresses: to_addresses,
        },
        source: from_address,
        message: text_messages,
      }

      client.send_email(parameters)
    end

    def create_text_message(charset, subject, text_message)
      {
        subject: {
          charset: charset,
          data: subject,
        },
        body: {
          text: {
            charset: charset,
            data: text_message,
          }
        },
      }
    end
  end
end
