# frozen_string_literal: true

require './src/scripts/base'
require './src/aws/credential'

module S3
  class Base < ::Base
    def initialize
      @output = []
      super
    end

    def client
      @client ||= Aws::S3::Client.new(region: region, credentials: Aws::Credential.credentials)
    end

    def get_object(key)
      client.get_object({bucket: bucket, key: key})
    end

    def put_object(options)
      client.put_object(options)
    end

    def delete_object(key)
      client.delete_object({bucket: bucket, key: key})
    end

    def copy_object(options)
      client.copy_object(options)
    end

    def region
      settings.s3.region
    end

    def bucket
      settings.s3.bucket
    end

    def settings
      raise NotImplementedError
    end

    def output
      raise StandardError if @output.nil? or @output.empty?

      header = @output.shift
      puts "| #{header.join(" | ")} |"
      puts "|#{" :-- |" * header.size}"
      @output.each do |row|
        puts "| #{row.join(" | ")} |"
      end
    end
  end
end
