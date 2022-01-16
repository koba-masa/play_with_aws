require 'aws-sdk-s3'
require './src/aws/credential'

module Aws
  class S3Client
    def initialize(bucket_name, region)
      @bucket_name = bucket_name
      @region = region
    end

    def client
      @client ||= Aws::S3::Client.new(
        region: @region,
        credentials: Credential.credentials,
      )
    end

    def upload_put_object(options)
      client.put_object(options)
    end

    def ls_key(key)
      client.list_objects_v2(
        {
          bucket: @bucket_name,
          prefix: key,
        }
      )
    end

    def download(key)
      client.get_object(
        {
          bucket: @bucket_name,
          key: key,
        }
      )
    end

    def delete(key)
      client.delete_object(
        {
          bucket: @bucket_name,
          key: key,
        }
      )
    end
  end
end
