# frozen_string_literal: true

require './src/base'
require './src/aws/s3_client'

class CopyObjectWithMetadata < Base
  def execute
    setup
    copy_without_metadata_copy
    copy_with_metadata_copy
    copy_without_metadata_replace
    copy_with_metadata_replace
  end

  def setup
    puts 'コピー元ファイル'
    s3_client.delete(source_file)
    s3_client.upload_put_object({
                                  bucket: bucket,
                                  key: source_file,
                                  body: upload_file,
                                  content_type: 'application/json',
                                  cache_control: 'max-age=1',
                                  metadata: {
                                    user_metadata: 'user_metadata'
                                  }
                                })
    output(source_file)
  end

  def copy_without_metadata_copy
    puts 'メタデータ:未指定 / メタデータ保持:COPY'
    key = "#{prefix}/copy_with_metadata_copy.json"
    s3_client.delete(key)
    options = nil
    copy(key, options)
    output(key)
  end

  def copy_with_metadata_copy
    puts 'メタデータ:指定 / メタデータ保持:COPY'
    key = "#{prefix}/copy_with_metadata_copy.json"
    s3_client.delete(key)
    options = {
      content_type: 'text/html',
      cache_control: 'max-age=2',
      metadata: {
        user_metadata: 'sample'
      }
    }
    copy(key, options)
    output(key)
  end

  def copy_without_metadata_replace
    puts 'メタデータ:未指定 / メタデータ保持:REPLACE'
    key = "#{prefix}/copy_without_metadata_replace.json"
    s3_client.delete(key)
    options = {
      metadata_directive: 'REPLACE'
    }
    copy(key, options)
    output(key)
  end

  def copy_with_metadata_replace
    puts 'メタデータ:指定 / メタデータ保持:REPLACE'
    key = "#{prefix}/copy_with_metadata_replace.json"
    s3_client.delete(key)
    options = {
      metadata_directive: 'REPLACE',
      content_type: 'text/html',
      cache_control: 'max-age=2',
      metadata: {
        user_metadata: 'sample'
      }
    }
    copy(key, options)
    output(key)
  end

  def copy(destination_key, additional_options)
    options = {
      bucket: bucket,
      copy_source: "#{bucket}/#{source_file}",
      key: destination_key
    }
    options = options.merge(additional_options) unless additional_options.nil?
    s3_client.copy_object(options)
  end

  def s3_client
    @s3_client ||= Aws::S3Client.new(bucket, region)
  end

  def source_file
    "#{prefix}/source.json"
  end

  def bucket
    settings.s3.bucket
  end

  def region
    settings.s3.region
  end

  def prefix
    settings.s3.prefix
  end

  def upload_file
    settings.s3.file
  end

  def settings
    Settings.copy_object_with_metadata
  end

  def output(key)
    result = s3_client.download(key)
    puts "  key: #{key}"
    puts "    content_type : #{result.content_type}"
    puts "    cache_control: #{result.cache_control}"
    puts '    metadata     :'
    result.metadata.each do |k, v|
      puts "      #{k}: #{v}"
    end
  end
end

CopyObjectWithMetadata.new.execute
